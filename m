Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86C1DBA11
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2019 01:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441666AbfJQXMk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Oct 2019 19:12:40 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34381 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441544AbfJQXMk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Oct 2019 19:12:40 -0400
Received: by mail-il1-f196.google.com with SMTP id c12so3813196ilm.1
        for <linux-ext4@vger.kernel.org>; Thu, 17 Oct 2019 16:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C+0CPSRvyze3i0OAGF6jRt0Y0jvNCqBQ68QSaFSVjuI=;
        b=GBAMPTBUAfZXEXI1lTBZvycDc1mCCN+6vmkXr3B8tr6pMw0VZj4013p22j40XQgYRX
         fpb67SZ/2Ogpm3FkoKlYuqdbN/eKlHx9GmoNczUCbzhchnzCXf0MwlFPLLrGX415b1eQ
         DmimY56OyDY61MB8fB7G8q+PBsYZtysxeUwAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C+0CPSRvyze3i0OAGF6jRt0Y0jvNCqBQ68QSaFSVjuI=;
        b=B+iMKOIKhGUQSRpwvSXXkPhNLWKcsZqFYUppztYU8KMJqtbVfqycZyQKY9Zuf0dbY4
         BTc8bD3MYCM+6lCceheqdImZF0p92PKFetF1h9Q9ljO3w8bC3VBHmMPrivs2uYTO1okZ
         K6pVyj5Mool/y3bveT+KX6KTiwjYq2z35rnlAYZdCfEjqY+OAXzL42C3kOj8DV0wEPKF
         Ajqr9c0wpl4A3/6SA9kMRxE7RXZPr5Zjmrd1nnrk3SxmfxCOqU4PvTKeu0hXyqoBFKml
         6UHj3jSUGZrKJN1bCYPkp1oq1pvpf+eelKDaEPssApYboGKtnBRzie6hghHxkzIwElRq
         RysQ==
X-Gm-Message-State: APjAAAUlQiAdOCBN7tW7E9qf0YBs4KQz7VdwEsP+FKppeRbLdqECS3zw
        BWwJelUthcKHQGNfZpog+mafL4k73cNh/w==
X-Google-Smtp-Source: APXvYqyChvp0O8KNa9NRfocOqUJ8BV+7FN2QTNBNv3UKutgU7Hz0ei9Hs7O6KQthhrPcZa4yUA8xCQ==
X-Received: by 2002:a92:5e4d:: with SMTP id s74mr6818458ilb.8.1571353958914;
        Thu, 17 Oct 2019 16:12:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c9sm1722506ilf.0.2019.10.17.16.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 16:12:38 -0700 (PDT)
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20191010023931.230475-1-yzaikin@google.com>
 <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
 <957434b6-32cc-487f-f48e-f9c4416b3f60@linuxfoundation.org>
 <CAAXuY3r7Eu+o-td8MRvexGYmONPgd8FvHr+7mF84Q4ni1G3URg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <40073fc9-1de1-9253-e2f9-9cf9ee4308d4@linuxfoundation.org>
Date:   Thu, 17 Oct 2019 17:12:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAXuY3r7Eu+o-td8MRvexGYmONPgd8FvHr+7mF84Q4ni1G3URg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 10/17/19 5:07 PM, Iurii Zaikin wrote:
>> Having the ability to take test data doesn't make it non-deterministic
>> though. It just means that if user wants to test with a different set
>> of data, there is no need to recompile the test. This could be helpful
>> to test cases the test write didn't think about.
>>
> Again, unit tests are not meant to be babysat. They are intended to become
> a part of the codebase and be run against every proposed change to ensure
> the change doesn't break anything.
> The whole process is supposed to be fully automated.
> Imagine a KUnit test run for all tests that gets kicked off as soon as a patch
> shows up in Patchwork and the maintainers getting the test run results.
> If you can think of a test that the change author didn't for a new corner case,
> then you as the maintainer ask the change author to add such test.
> Or if some corner case comes up as a result of a bug then the new case is
> submitted with the fix.
> This is how unit testing is deployed in the larger software world. In the most
> enlightened places a change will not be accepted unless it's accompanied by
> the unit tests that offer good coverage for the possible inputs and code paths.
> A change that breaks existing tests is either incorrect and has to be fixed or
> the existing tests need to be updated for the behavior change.
> 

Okay. I am asking for an option to override the test data. You didn't
address that part.

You can do all of this and allow users to supply another set of data.
It doesn't gave to be one or the other.

thanks,
-- Shuah
