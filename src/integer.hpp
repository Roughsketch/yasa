#ifndef YASA_INTEGER
#define YASA_INTEGER

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
      m_bytes = strlen(str) / 2 + strlen(str) % 2;
      m_realbytes = m_value == 0 ? 1 : (std::log2(m_value) / 8) + 1;
    }

    Integer(int value, int bytes, int real)
    {
      m_value = value;
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

  private:
    int m_value;
    int m_bytes;
    int m_realbytes;
  };
}

#endif
