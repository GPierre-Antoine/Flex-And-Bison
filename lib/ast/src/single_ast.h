//
// Created by pierreantoine on 12/01/2020.
//


#pragma once


#include <memory>
#include "ast.h"

namespace v1::ast::fb31
{
    template <typename T>
    class single_ast : public ast<T>
    {
    public:
        const char symbol;
    private:
        typedef ast<T>* astptr;
        astptr child;
    public:
        ~single_ast() override;
        T accept(ast_visitor<T> & visitor) override;
        T accept(ast_visitor<T> && visitor) override;

        single_ast(char symbol, astptr child);

        ast<T> & get_child();
    };
}

template <typename T>
T v1::ast::fb31::single_ast<T>::accept(v1::ast::fb31::ast_visitor<T> & visitor)
{
    return visitor.visit(*this);
}
template <typename T>
T v1::ast::fb31::single_ast<T>::accept(v1::ast::fb31::ast_visitor<T> && visitor)
{
    return visitor.visit(*this);
}

template <typename T>
v1::ast::fb31::single_ast<T>::single_ast(char symbol, astptr child)
        :  ast<T>(), symbol(symbol), child(child)
{
}

template <typename T>

v1::ast::fb31::ast<T> & v1::ast::fb31::single_ast<T>::get_child()
{
    return *child;
}
template <typename T>
v1::ast::fb31::single_ast<T>::~single_ast()
{
    delete child;
    child=0;
}
