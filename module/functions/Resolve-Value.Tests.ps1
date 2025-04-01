# <copyright file="Resolve-Value.Tests.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

BeforeAll {
    # sut
    . $PSCommandPath.Replace('.Tests.ps1','.ps1')
}

Describe 'Resolve-Value' {
    
    Context 'Static value' {
        
        It 'should return the original value' {
            Resolve-Value -Value 'StaticValue' | Should -Be 'StaticValue'
        }
    }

    Context 'Static value via pipeline' {
        
        It 'should return the original value' {
            'StaticValue' | Resolve-Value | Should -Be 'StaticValue'
        }
    }

    Context 'Dynamic value' {
        
        It 'should return the original value' {
            Resolve-Value -Value { 2 + 2 } | Should -Be 4
        }
    }

    Context 'Dynamic value via pipeline' {
        
        It 'should return the original value' {
            { 2 + 2 } | Resolve-Value | Should -Be 4
        }
    }
    
}