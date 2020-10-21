Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C14929550A
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 01:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507038AbgJUXHZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 19:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507032AbgJUXHY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 19:07:24 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE02C0613CE;
        Wed, 21 Oct 2020 16:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=2dR+3lcuV/E+b2J/xvzO1yZQ9dnsa13/I5Reb3BJkgw=; b=U7Buj/VunPk7Yvc+3gaM6Q5CNP
        ITTWi8LdXv27ZmwS5zWcx6XA82+Ozb9MjeaOtg7a40SyK38v15VxyAfp4p9YpdxlepxtcRFS12N8x
        5b1bpsrGrqYGwzkZeOD26n3ZVhmX0d8XxGq/P2Svr0O7L8l1+fIcCm5r7Zd9kAjHxjAmCKVoObuPp
        /1qoUFBMMcVAeLSRprR8UPeUuA0HlIH0q3mQ87udjSqMe83eog3JxcQtFGURpiEWYpqTWOSuJjwY/
        gbuBXEL0rIWxNBz8CSzbEZGIB9cFUBTzw9SqZp723f5ZnQuRyk+WROaEn6ATedfzuI9lk8hdmQwJI
        nxDIsPJQ==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVNCS-0000A6-UB; Wed, 21 Oct 2020 23:07:21 +0000
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b51d57fd-061a-26f3-5ecc-8efecbc95a49@infradead.org>
Date:   Wed, 21 Oct 2020 16:07:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201021223649.GP181507@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 10/21/20 3:36 PM, Theodore Y. Ts'o wrote:
> On Wed, Oct 21, 2020 at 02:16:56PM -0700, Randy Dunlap wrote:
>> On 10/21/20 2:15 PM, Brendan Higgins wrote:
>>> On Tue, Oct 20, 2020 at 12:37 AM Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>>
>>>> EXT4_KUNIT_TESTS selects EXT4_FS, thus enabling an optional feature the
>>>> user may not want to enable.  Fix this by making the test depend on
>>>> EXT4_FS instead.
>>>>
>>>> Fixes: 1cbeab1b242d16fd ("ext4: add kunit test for decoding extended timestamps")
>>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>
>>> If I remember correctly, having EXT4_KUNIT_TESTS select EXT4_FS was
>>> something that Ted specifically requested, but I don't have any strong
>>> feelings on it either way.
>>
>> omg, please No. depends on is the right fix here.
> 
> So my requirement which led to that particular request is to keep what
> needs to be placed in .kunitconfig to a small and reasonable set.
> 
> Per Documentation/dev-tools/kunit, we start by:
> 
>     cd $PATH_TO_LINUX_REPO
>     cp arch/um/configs/kunit_defconfig .kunitconfig
> 
> we're then supposed to add whatever Kunit tests we want to enable, to wit:
> 
> CONFIG_EXT4_KUNIT_TESTS=y
> 
> so that .kunitconfig would look like this:
> 
> CONFIG_KUNIT=y
> CONFIG_KUNIT_TEST=y
> CONFIG_KUNIT_EXAMPLE_TEST=y
> CONFIG_EXT4_KUNIT_TESTS=y
> 
> ... and then you should be able to run:
> 
> ./tools/testing/kunit/kunit.py run
> 
> ... and have the kunit tests run.  I would *not* like to have to put a
> huge long list of CONFIG_* dependencies into the .kunitconfig file.
> 
> I'm don't particularly care how this gets achieved, but please think
> about how to make it easy for a kernel developer to run a specific set
> of subsystem unit tests.  (In fact, being able to do something like
> "kunit.py run fs/ext4 fs/jbd2" or maybe "kunit.py run fs/..." would be
> *great*.  No need to fuss with hand editing the .kunitconfig file at
> all would be **wonderful**.

I understand the wish for ease of use, but this is still the tail
wagging the dog.

The primary documentation for 'select' is
Documentation/kbuild/kconfig-language.rst, which says:

  Note:
	select should be used with care. select will force
	a symbol to a value without visiting the dependencies.
	By abusing select you are able to select a symbol FOO even
	if FOO depends on BAR that is not set.
	In general use select only for non-visible symbols
	(no prompts anywhere) and for symbols with no dependencies.
	That will limit the usefulness but on the other hand avoid
	the illegal configurations all over.


-- 
~Randy

