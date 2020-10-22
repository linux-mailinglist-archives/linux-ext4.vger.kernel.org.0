Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCDD2956FD
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 05:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895575AbgJVDzr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 23:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895568AbgJVDzr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 23:55:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B9BC0613CE;
        Wed, 21 Oct 2020 20:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=H+lYsXHdQoVC2le+FTTS26+nkw0LNtdz8WsuNJPbye0=; b=0Fch1q2FwHCP7HfqF9FCauyZXy
        jWSi38ZuRNiwj+Yx+6aoxCA4Gh9NaOfM7wnRLkxpXOjfmoy8Igj9AGNMR5afBpO5zWQuBVyWQTgF/
        0bFUXCibZgcgDIGuOVzqwofLQeULgxTo5qnna1h7fvei/o1TCQzg+qxnylaZLXCqQ6xbQcJSxWcI/
        j7TJr9Y8CykNHdJW8B5ykrF8Ami5bFRqeuEfQI8uVC2NHI5Y1Xb1c3sj/1YrPdbmT5NLLzgQB0Wjo
        EHGX2NGQ4aRle0ctQTj4x4aZFIMaHLcG6caXlP9NvQ0YmrSMatENeB26AaChIf1zBcg1li3CChtua
        NLgElg1g==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVRhW-0007PY-WD; Thu, 22 Oct 2020 03:55:43 +0000
Subject: Re: [PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead of
 selecting it
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
References: <20201020073740.29081-1-geert@linux-m68k.org>
 <CAFd5g44dGaKyDQGPeanE1G8MPzVdVkqbWjJhj+nQJGUgkezz9g@mail.gmail.com>
 <fa84c31f-218f-76be-87de-aa85c3c9b621@infradead.org>
 <20201021223649.GP181507@mit.edu>
 <b51d57fd-061a-26f3-5ecc-8efecbc95a49@infradead.org>
 <20201022034343.GQ181507@mit.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <04d63aa1-ec2b-e6d2-5b51-6c05c5338ded@infradead.org>
Date:   Wed, 21 Oct 2020 20:55:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022034343.GQ181507@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 10/21/20 8:43 PM, Theodore Y. Ts'o wrote:
> On Wed, Oct 21, 2020 at 04:07:15PM -0700, Randy Dunlap wrote:
>>> I'm don't particularly care how this gets achieved, but please think
>>> about how to make it easy for a kernel developer to run a specific set
>>> of subsystem unit tests.  (In fact, being able to do something like
>>> "kunit.py run fs/ext4 fs/jbd2" or maybe "kunit.py run fs/..." would be
>>> *great*.  No need to fuss with hand editing the .kunitconfig file at
>>> all would be **wonderful**.
>>
>> I understand the wish for ease of use, but this is still the tail
>> wagging the dog.
>>
>> The primary documentation for 'select' is
>> Documentation/kbuild/kconfig-language.rst, which says:
>>
>>   Note:
>> 	select should be used with care. select will force
>> 	a symbol to a value without visiting the dependencies.
>> 	By abusing select you are able to select a symbol FOO even
>> 	if FOO depends on BAR that is not set.
>> 	In general use select only for non-visible symbols
>> 	(no prompts anywhere) and for symbols with no dependencies.
>> 	That will limit the usefulness but on the other hand avoid
>> 	the illegal configurations all over.
>>
> 
> Well, the KUNIT configs are kinda of a special case, since normally
> they don't have a lot of huge number of dependencies, since unit tests
> in general are not integration tests.  So ideally, dependencies will
> mostly be replaced with mocking functions.  And if there are *real*
> dependencies that the Kunit Unit tests need, they can be explicitly
> pulled in with selects.
> 
> That being said, as I said, I'm not picky about *how* this gets
> achieved.  But ease of use is a key part of making people more likely
> to run the unit tests.  So another way of solving the problem might be
> to put some kind of automated dependency solver into kunit.py, or some
> way of manually adding the necessary dependencies in some kind of
> Kunitconfig file that are in directories where their are Unit tests,
> or maybe some kind of extenstion to the Kconfig file.  My main
> requirement is that the only thing that should be necessary for
> enabling the ext4 Kunit tests should be adding a single line to the
> .kunitconfig file.  It's not fair to make the human developer manually
> have to figure out the dependency chains.
> 
> As far as I'm concerned, ease of use is important enough to justfy
> special casing and/or bending the rules as far as "select" is concered
> for Kunit-related CONFIG items.  But if someone else want to suggest a
> better approach, I'm all ears.
> 
> Cheers,

Indeed.  For the record, I support testing and have for a long time.
I just don't care for this big fscking hammer approach.
But I doubt that I can change your mind.

g'day.
-- 
~Randy

