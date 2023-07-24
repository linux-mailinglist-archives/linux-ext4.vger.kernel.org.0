Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E346075EC65
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jul 2023 09:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjGXHWr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jul 2023 03:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXHWr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jul 2023 03:22:47 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EC4A0
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 00:22:46 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3461053677eso9384075ab.0
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 00:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690183365; x=1690788165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VMjVeE5XCp9Lx1QBo1M7c4cB8MRjGjQBTgS8j3bhMTQ=;
        b=iTDq64BhEmMmiTmGJv4lsqXJ+nj0/MskrQLaxSAIQ5IzanL6iptheyMfYgK8nFPTHm
         /HUe8wdKGH3SMQr52WGO5Bae4EcH+FkM17foD7MyUt8C1hduGi1RSl24sKmBIDpy6Z9u
         2hlRvxz5dYUS1Trnsw8Xexll0z+3FteEnAswBW10gXRHaFQJ59o3wSG4H/L82dXrLD8Q
         nIQI4vk9dtPtx9uvlK0RXY8A2/Vh3CmKBfQIeIrc5YQqaDrQZteDzkJPCSu1UZIpVM5M
         1GGnAKbsgFFpO+7Fj8dRBCNN9HHUOZ8oJKPLpoR6gkMdx1P/QGFdFwSWSpok6WQgFCLQ
         nvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690183365; x=1690788165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMjVeE5XCp9Lx1QBo1M7c4cB8MRjGjQBTgS8j3bhMTQ=;
        b=CcdJF+3OOEGjUHhYl+33ZIB8/UTrEkLUDPnjRJXFEgzpbfAOLQ5w/ThdZiCBQCB4bj
         AHn/ScBLs0h2RUce3ip+Y2ke+yq8xe81sBmWwD75JfzcLixXGyaBd5nMHLJamYaShqF4
         B06zD+SSqVqrFE9unVa5JYRaA7nclPVMbyw+U2LJVin49pSwDeY1wJvoonOmrYhv4Que
         RLvVLsXyQnn64Nn5mpCqLtyjCGdf+Pt88aTMbPhcocV6NzBHoUItCBGZWnPnngmG9Eq3
         fdWuPznYCk/Vd4Vbo8dvaPrKRzWf8uCkbH3XXVp5ONNla+8usSqAX2BN1Yrlai9UwPff
         9acg==
X-Gm-Message-State: ABy/qLZB2Pgo2fKpGukpBKqa9T7fQx18Adbe3o/Xw/QKRO7UU6imH9U/
        Fr8/theW5LGZtltypAtNDSXFbAQtyM0dSJMUKKqxlV4KHARhrA==
X-Google-Smtp-Source: APBJJlEvm7CV+uAu+sALIyxdPJZo9FIUdKLB0V8o1+kBX3CkQurTUY38JliI3PfyTLbJy85LHwX79z5M98tOpPLQbE4=
X-Received: by 2002:a05:6e02:1a04:b0:348:d3e3:9a8f with SMTP id
 s4-20020a056e021a0400b00348d3e39a8fmr1436455ild.11.1690183365607; Mon, 24 Jul
 2023 00:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230719093633.34141-1-changfengnan@bytedance.com> <7aec48ca-c7fa-df42-8a09-5dea9c762c2e@linux.dev>
In-Reply-To: <7aec48ca-c7fa-df42-8a09-5dea9c762c2e@linux.dev>
From:   fengnan chang <fengnanchang@gmail.com>
Date:   Mon, 24 Jul 2023 15:22:34 +0800
Message-ID: <CALWNXx-6y0=ZDBMicv2qng9pKHWcpJbCvUm9TaRBwg81WzWkWQ@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: improve discard efficiency
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Fengnan Chang <changfengnan@bytedance.com>,
        adilger.kernel@dilger.ca, tytso@mit.edu,
        linux-ext4@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="0000000000001ce3a00601367b1c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--0000000000001ce3a00601367b1c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 11:42=E2=80=AFAM Guoqing Jiang <guoqing.jiang@linux=
.dev> wrote:
>
> Hi,
>
> On 7/19/23 17:36, Fengnan Chang wrote:
> > In commit a015434480dc("ext4: send parallel discards on commit
> > completions"), issue all discard commands in parallel make all
> > bios could merged into one request, so lowlevel drive can issue
> > multi segments in one time which is more efficiency, but commit
> > 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> > seems broke this way, let's fix it.
> > In my test, the time of fstrim fs with multi big sparse file
> > reduce from 6.7s to 1.3s.
>
> I tried with a 20T sparse file with latest kernel (6.5-rc2+ commit
> f7e3a1baf).
>
> truncate -s 20T sparse1.img
> mkfs.ext4 sparse1.img
> mount -o discard sparse1.img /mnt/
> time fstrim /mnt
>
> 1. without the patch
>
> [root@localhost ~]# time fstrim /mnt
>
> real    0m13.496s
> user    0m0.002s
> sys     0m5.202s
>
> 2. with the patch
>
> [root@localhost ~]# time fstrim /mnt
>
> real    0m15.956s
> user    0m0.000s
> sys     0m7.251s
>
> The result is different from your side, could you share your test?

Here are my test steps:
1. create 10 normal files, each file size is 10G.
2. deallocate file=EF=BC=9Apunch holes every 16k. The attached file include=
s step 1&2.
3. trim all fs.
So why does trim a new fs become slow? because with my patch,  in
ext4_try_to_trim_range
we need do alloc and free memory, this might cause 9us cost in
addition. So in current
version,  benefits can only be gained if there are multiple
discontinuous segments that
need to be trimmed in  ext4_try_to_trim_range.
This problem needs to be fixed, so I'll send another version.

Thanks.
Fengnan

>
> Thanks,
> Guoqing

--0000000000001ce3a00601367b1c
Content-Type: application/octet-stream; name="makefrag.c"
Content-Disposition: attachment; filename="makefrag.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lkgj3x4n0>
X-Attachment-Id: f_lkgj3x4n0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8c3RyaW5ncy5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPGxp
bnV4L2ZhbGxvYy5oPgojZGVmaW5lIF9HTlVfU09VUkNFIAojaW5jbHVkZSA8ZmNudGwuaD4KI2lu
Y2x1ZGUgPHN5cy9pb2N0bC5oPgojaW5jbHVkZSA8bGludXgvZnMuaD4KI2luY2x1ZGUgPHN0ZGlv
Lmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDx0aW1l
Lmg+CgppbnQgZGVhbGxvY2F0ZV9ibG9ja19yYW5nZShpbnQgZmQsIGludCBzdGFydF9ibG9jaywg
aW50IGNvdW50KQp7CiAgICB1bnNpZ25lZCBsb25nIHN0YXJ0ID0gc3RhcnRfYmxvY2sgKiA0MDk2
OyAvLyDku6XlrZfoioLkuLrljZXkvY3mj4/ov7DlnZfnmoTojIPlm7QKICAgIHVuc2lnbmVkIGxv
bmcgbGVuID0gY291bnQgKiA0MDk2OyAvLyDku6XlrZfoioLkuLrljZXkvY3mj4/ov7DlnZfnmoTo
jIPlm7QKCiAgICBpZiAoZmFsbG9jYXRlKGZkLCBGQUxMT0NfRkxfUFVOQ0hfSE9MRSB8IEZBTExP
Q19GTF9LRUVQX1NJWkUsCiAgICAgICAgICAgICAgICAgc3RhcnQsIGxlbikgPT0gLTEpIHsKICAg
ICAgICBwZXJyb3IoImZhbGxvY2F0ZSIpOwogICAgICAgIGV4aXQoRVhJVF9GQUlMVVJFKTsKICAg
IH0KICAgIHJldHVybiAwOwp9CgppbnQgY3JlYXRlX2ZpbGUoY2hhciAqZmlsZSkgewogICAgaW50
IGZkID0gb3BlbihmaWxlLCBPX1dST05MWSB8IE9fQ1JFQVQgfCBPX1RSVU5DLCAwNjY2KTsKICAg
IC8vIOaJk+W8gOaWh+S7tu+8jOS7peWGmeWFpeaWueW8j+aJk+W8gO+8jOiLpeS4jeWtmOWcqOWI
meWIm+W7uu+8jOadg+mZkOS4ujY2Nu+8jOaWh+S7tumVv+W6puS4ujAKICAgIGlmIChmZCA9PSAt
MSkgewogICAgICAgIHByaW50ZigiRmFpbCB0byBjcmVhdGUgZmlsZSFcbiIpOwogICAgICAgIHJl
dHVybiAtMTsKICAgIH0KCiAgICB1bnNpZ25lZCBsb25nIGZpbGVfcyA9IDEwKjEwMjQqMTAyNCox
MDI0OwogICAgdW5zaWduZWQgbG9uZyBibG9ja19zaXplPSAxMDI0KjEwMjQ7CiAgICB1bnNpZ25l
ZCBsb25nIGNvdW50ID0gZmlsZV9zIC8gKDY0KiAxMDI0KTsKICAgIGNoYXIqIGJsb2NrID0gY2Fs
bG9jKDEsIGJsb2NrX3NpemUpOyAgLy8g55SoJ0En5aGr5YWF5q+P5Liq5Z2XCiAgICBtZW1zZXQo
YmxvY2ssIDB4M2YsIGJsb2NrX3NpemUpOwoKICAgIGZvciAoaW50IGkgPSAwOyBpIDwgZmlsZV9z
L2Jsb2NrX3NpemU7IGkrKykgewogICAgICAgIHdyaXRlKGZkLCBibG9jaywgYmxvY2tfc2l6ZSk7
ICAvLyDlhpnlhaXkuIDkuKrlnZcKICAgIH0KICAgIGZzeW5jKGZkKTsgIC8vIOWwhue8k+WtmOS4
reeahOaVsOaNruWIt+aWsOWIsOejgeebmAogICAgaW50IG9mZiA9IDA7CiAgICBmb3IgKGludCBp
ID0gMDsgaSA8IGNvdW50OyBpKyspIHsKCWRlYWxsb2NhdGVfYmxvY2tfcmFuZ2UoZmQsIG9mZiwg
OCk7CglvZmYgKz0gMTY7CiAgICB9CiAgICBjbG9zZShmZCk7ICAvLyDlhbPpl63mlofku7YKICAg
IHJldHVybiAwOwp9CgppbnQKbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCnsKCWZvcihpbnQg
aSA9IDA7IGkgPCAxMDsgaSsrKSB7CgkJY2hhciBuYW1lWzEyOF07CgkJc3ByaW50ZihuYW1lLCAi
dGVzdGZpbGVfJWQiLGkpOwoJCWNyZWF0ZV9maWxlKG5hbWUpOwoJfQoJcmV0dXJuIDA7Cn0K
--0000000000001ce3a00601367b1c--
