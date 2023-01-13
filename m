Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E68D668979
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jan 2023 03:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbjAMCRb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Jan 2023 21:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjAMCR3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Jan 2023 21:17:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254F95D6A1
        for <linux-ext4@vger.kernel.org>; Thu, 12 Jan 2023 18:17:28 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so4020365pjm.1
        for <linux-ext4@vger.kernel.org>; Thu, 12 Jan 2023 18:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGsajtc8LjifpVlmrbfb46/HblCKY9fCLhYkMZn0JJQ=;
        b=0ix5FnJEXNLiyOhb1MaYPziavhG5nMD4qS4uGxrVD2k8yuq+y9bGcWzL9S+7JzRN9i
         8qjOT3pa6PV4Gd+OEa1VzwLvd0x8iJa2zDRBM2FDbpsd6RoIgx9dtBhkCmI8CH5Vz4BE
         VW0kGtenH0X1y2xckf/hAgAXG0BccZIohTAPtmHJwIzyCZ1Mxg1tYVdmavKxm6apjk3/
         xp0kCBKLNfKDs/pPUId/UeRsOHpvx+e2IHbxQi7kbJZe3tsKRIDp7F0u3CgP7uhbLx06
         MiZzJ45TGvpzaQ3rFsUbM/phDVfgNz2N6Z1OT+Yr4hggV/L+i8TwGowj0p0fEibyNYSi
         6CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGsajtc8LjifpVlmrbfb46/HblCKY9fCLhYkMZn0JJQ=;
        b=kaZdQ7nIA0cRP6jZNFSGFOAVkzkL43NA6dlHfCP9UAt5h7ir7MVXlJxYGFmPWJTguy
         bLBIevImUeWAgALL6rd8vHYnJNLbQ5WRVAZ/OTol+qZ/cDfz1Nh7DPdbmnAkQgjo/eET
         5yYReoUP9UpJEqL+b+09gADB9g187FvOHiPQS7ABnZeWU8ASAyMh7me3bY5vVcvhFKAM
         cyWq/EpVna8G4W8Z9KffKNHI4gnug6IgGwJQ5atHOjOtpivs6SgDrOxfI1P+a0QAHew+
         Ps2BXp8+KuuL6dhblGl1q92h7Td3q2tgk7fPnatSoASEahX3RQgwIEC8NU6nuszZjN99
         cytA==
X-Gm-Message-State: AFqh2krDNaA6Eb0nsoUIBXrY3QB2qtlkQWdP4g68Nf4fnkfMljlRnBld
        u493szHIodjC1WUIsiTpkA5Nww==
X-Google-Smtp-Source: AMrXdXu+ZvxmOytwGQRUuYBnHGM3r17omZOu3Cl5IO25l4f4zEcdS3LbISm0cPYbkXFYVT99montqA==
X-Received: by 2002:a17:902:b48e:b0:18b:cea3:645 with SMTP id y14-20020a170902b48e00b0018bcea30645mr19782541plr.0.1673576247557;
        Thu, 12 Jan 2023 18:17:27 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b00189b2b8dbedsm12830011plh.228.2023.01.12.18.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 18:17:27 -0800 (PST)
Message-ID: <9d8339cf-5b66-959a-254d-839c0de92ec8@kernel.dk>
Date:   Thu, 12 Jan 2023 19:17:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [io_uring] KASAN: use-after-free Read in signalfd_cleanup
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     syzbot <syzbot+8317cc9c082c19d576a0@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu,
        viro@zeniv.linux.org.uk
References: <000000000000f4b96605f20e5e2f@google.com>
 <000000000000651be505f218ce8b@google.com> <Y8C+BXazOBbxTufZ@sol.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y8C+BXazOBbxTufZ@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 1/12/23 7:12 PM, Eric Biggers wrote:
> Over to the io_uring maintainers and list, based on the reproducer...:
> 
>     r0 = signalfd4(0xffffffffffffffff, &(0x7f00000000c0), 0x8, 0x0)
>     r1 = syz_io_uring_setup(0x87, &(0x7f0000000180), &(0x7f0000ffc000/0x3000)=nil, &(0x7f00006d4000/0x1000)=nil, &(0x7f0000000000)=<r2=>0x0, &(0x7f0000000040)=<r3=>0x0)
>     pipe(&(0x7f0000000080)={0xffffffffffffffff, <r4=>0xffffffffffffffff})
>     write$binfmt_misc(r4, &(0x7f0000000000)=ANY=[], 0xfffffecc)
>     syz_io_uring_submit(r2, r3, &(0x7f0000002240)=@IORING_OP_POLL_ADD={0x6, 0x0, 0x0, @fd=r0}, 0x0)
>     io_uring_enter(r1, 0x450c, 0x0, 0x0, 0x0, 0x0)

This was a buggy patch in a branch, already updated and can be discarded.

-- 
Jens Axboe


