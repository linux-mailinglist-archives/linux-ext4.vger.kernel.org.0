Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4901295438
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506189AbgJUVbC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 17:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440458AbgJUVbC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 17:31:02 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF32C0613CE;
        Wed, 21 Oct 2020 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=rSq4aHLNIa3WJW9fS/4WwXYWjAQEL9bnpVvNu4R47Rw=; b=GpBm2aovtENMe0nHFyxYegrjwO
        JmDG+z8mdJaGMIIQDShectofao4q1QWwGAQZrgzA6Ew8xd3UJfdQtpXPc2r28ODIFBzT5emrYNso5
        YMdmV8SeVfYM3vs0wowAtzx0IwPdmYUMTKoh4UqFSQVrPHUcjkLmGJY42qqcF+2SIEQVJgxVHxPY9
        qdzpPyoFYMGzIzGZTWeY82isrVgxQN7fAqZxh1iBDk4FXrOY7/S658i8VBSbHMgyNSRMQBQrcIg+0
        7qLj5LjCTtKt4u32ZDrjmjNfSn4hGD0njUpc8LIOigaZOnnB2QbSVIxKPT3uYO3ILqxbJNf/DUb4y
        ItiWMYog==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVLhC-0000sP-5o; Wed, 21 Oct 2020 21:30:58 +0000
Subject: Re: [PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead of
 selecting it
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201020073740.29081-1-geert@linux-m68k.org>
 <CAFd5g44dGaKyDQGPeanE1G8MPzVdVkqbWjJhj+nQJGUgkezz9g@mail.gmail.com>
 <CABVgOSmRbZqDw83f1Z14nSSVQTeFOvyehXhB=NnbaaANrwe=FQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <52959e99-4105-3de9-730c-c46894b82bdd@infradead.org>
Date:   Wed, 21 Oct 2020 14:30:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CABVgOSmRbZqDw83f1Z14nSSVQTeFOvyehXhB=NnbaaANrwe=FQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 10/21/20 2:29 PM, David Gow wrote:
> On Thu, Oct 22, 2020 at 5:15 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
>>
>> On Tue, Oct 20, 2020 at 12:37 AM Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>>
>>> EXT4_KUNIT_TESTS selects EXT4_FS, thus enabling an optional feature the
>>> user may not want to enable.  Fix this by making the test depend on
>>> EXT4_FS instead.
>>>
>>> Fixes: 1cbeab1b242d16fd ("ext4: add kunit test for decoding extended timestamps")
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> If I remember correctly, having EXT4_KUNIT_TESTS select EXT4_FS was
>> something that Ted specifically requested, but I don't have any strong
>> feelings on it either way.
> 
> For what it's worth, the upcoming FAT filesystem tests[1] are also
> select-ing FAT_FS at the moment, so if this changes here, I'll likely
> update it there as well.
> 
> -- David
> 
> [1]: https://lore.kernel.org/linux-kselftest/20201021061713.1545931-1-davidgow@google.com/T/#u
> 

then hopefully both get updated. This is just backwards.

-- 
~Randy

