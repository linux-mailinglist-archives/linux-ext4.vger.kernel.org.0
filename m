Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2AD295402
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 23:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505983AbgJUVRG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 17:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505979AbgJUVRG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 17:17:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B454BC0613CE;
        Wed, 21 Oct 2020 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=L9KnamqfyhOdaOnsHrZ3+u3zuYCeeODQD2KveoFX8B4=; b=dxGEwJFIkFhR4AGD6OIasdLsGm
        X7Zaf8U/UPlthCqRigt8VFsfISdBNgvkrkhOklbHb/6VuifWU6K9BSH7Hkm+IUAqlU/JbuPSzHoBQ
        PaEfpdRROppqf3ViL7v1UVvef4kT2LE75Dcqgvt1JKESCoJJm93AibfBs5GqJrGAjoA508w0w2myy
        ECuBgm9HUAX3dnxQJtY0U1NgeOlBIltWkqISdxf8iLWkBsupONq8ph2kxoTeUshHBnOQ4ABgf3tjx
        bxSkfOsjyoXWtFPhJLv78Vlz9JimQEYkILK+GHsn27XoLJRj4s3pwK/u9tDdgprEHJUNdVrrxqnXM
        w2ftX8Fg==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVLTi-0008Cd-8p; Wed, 21 Oct 2020 21:17:02 +0000
Subject: Re: [PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead of
 selecting it
To:     Brendan Higgins <brendanhiggins@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fa84c31f-218f-76be-87de-aa85c3c9b621@infradead.org>
Date:   Wed, 21 Oct 2020 14:16:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g44dGaKyDQGPeanE1G8MPzVdVkqbWjJhj+nQJGUgkezz9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 10/21/20 2:15 PM, Brendan Higgins wrote:
> On Tue, Oct 20, 2020 at 12:37 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>>
>> EXT4_KUNIT_TESTS selects EXT4_FS, thus enabling an optional feature the
>> user may not want to enable.  Fix this by making the test depend on
>> EXT4_FS instead.
>>
>> Fixes: 1cbeab1b242d16fd ("ext4: add kunit test for decoding extended timestamps")
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> If I remember correctly, having EXT4_KUNIT_TESTS select EXT4_FS was
> something that Ted specifically requested, but I don't have any strong
> feelings on it either way.

omg, please No. depends on is the right fix here.

-- 
~Randy

