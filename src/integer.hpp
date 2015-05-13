#ifndef YASA_INTEGER
#define YASA_INTEGER

#include <sstream>
#include <iomanip>
#include <iostream>
#include <cstdlib>
#include <cstring>
#include <cmath>

namespace yasa
{
  struct Integer 
  {
    Integer(const char *str, int base = 10)
    {
      m_value = strtol(str, NULL, base);
      m_realbytes = m_value == 0 ? 1 : (std::log2(m_value) / 8) + 1;

      int size = (this->to_string().size() - 1); // Hex number - the $

      m_bytes = size / 2 + size % 2;
    }

    Integer(int value, int bytes = 0, int real = 0)
    {
      m_value = value;

      if (bytes == 0)
      {
        bytes = m_value == 0 ? 1 : (std::log2(m_value) / 8) + 1;
        real = bytes;
      }

      m_bytes = bytes;
      m_realbytes = real;
    }

    operator int()
    {
      return m_value;
    }

    Integer operator+(Integer& rhs)
    {
      return Integer(this->value() + rhs.value(), std::max(m_bytes, rhs.size()), std::max(m_realbytes, rhs.realsize()));
    }

    Integer operator-(Integer& rhs)
    {
      return Integer(this->value() - rhs.value(), std::max(m_bytes, rhs.size()), std::max(m_realbytes, rhs.realsize()));
    }

    Integer operator*(Integer& rhs)
    {
      return Integer(this->value() * rhs.value(), std::max(m_bytes, rhs.size()), std::max(m_realbytes, rhs.realsize()));
    }

    Integer operator/(Integer& rhs)
    {
      return Integer(this->value() / rhs.value(), std::max(m_bytes, rhs.size()), std::max(m_realbytes, rhs.realsize()));
    }

    Integer operator%(Integer& rhs)
    {
      return Integer(this->value() % rhs.value(), std::max(m_bytes, rhs.size()), std::max(m_realbytes, rhs.realsize()));
    }

    Integer operator|(Integer& rhs)
    {
      return Integer(this->value() | rhs.value(), std::max(m_bytes, rhs.size()), std::max(m_realbytes, rhs.realsize()));
    }

    Integer operator&(Integer& rhs)
    {
      return Integer(this->value() & rhs.value(), std::max(m_bytes, rhs.size()), std::max(m_realbytes, rhs.realsize()));
    }

    Integer operator^(Integer& rhs)
    {
      return Integer(this->value() ^ rhs.value(), std::max(m_bytes, rhs.size()), std::max(m_realbytes, rhs.realsize()));
    }

    Integer operator>>(Integer& rhs)
    {
      return Integer(this->value() >> rhs.value(), std::max(m_bytes, rhs.size()), std::max(m_realbytes, rhs.realsize()));
    }

    Integer operator<<(Integer& rhs)
    {
      return Integer(this->value() << rhs.value(), std::max(m_bytes, rhs.size()), std::max(m_realbytes, rhs.realsize()));
    }

    inline int parse()
    {

    }

    inline int value()
    {
      return m_value;
    }

    inline int size()
    {
      return m_bytes;
    }

    inline int realsize()
    {
      return m_realbytes;
    }

    inline std::string to_string()
    {
      std::stringstream stream;

      stream << "$" << std::setfill('0') << std::setw(m_bytes * 2) << std::hex << m_value;

      std::string temp = stream.str();

      std::cout << "Returning " << temp << std::endl;

      return temp;
    }
  private:
    int m_value;
    int m_bytes;
    int m_realbytes;
  };
}

#endif
