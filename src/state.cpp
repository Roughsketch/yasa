#include "state.hpp"

void State::setmode(RomLayout layout)
{
  rom_type = layout;
}

std::string *State::add_sublabel_name(const char *text)
{
  std::string sublabel = "";
  std::string id = std::string(text);
  int i = 0;

  while (id[i] == '.')
  {
    if (i > label_ids.size())
    {
      std::cout << "Error: sublabel goes deeper than expected. (line " << yylineno << ")" << std::endl;
      return nullptr;
    }

    sublabel += label_ids[i] + "_";
    i++;
  }

  id = id.substr(i);

  //  Sublabel was dedented
  if (i != label_ids.size())
  {
    //  Erase all sublabels deeper than this one
    label_ids.erase(label_ids.begin() + i, label_ids.end());
  }
  
  //  Push back the new sublabel
  label_ids.push_back(id);
  return new std::string(sublabel + id);
}

std::string State::get_sublabel_name(const char *text)
{
  std::string sublabel = "";
  std::string id = std::string(text);
  int i = 0;

  while (id[i] == '.')
  {
    if (i > label_ids.size())
    {
      std::cout << "Error: sublabel goes deeper than expected. (line " << yylineno << ")" << std::endl;
      return nullptr;
    }

    sublabel += label_ids[i] + "_";
    i++;
  }

  return sublabel + id;
}