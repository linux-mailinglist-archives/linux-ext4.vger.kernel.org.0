Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D452135278B
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 10:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBInx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 2 Apr 2021 04:43:53 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:33820 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBInw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Apr 2021 04:43:52 -0400
Received: from SZ11126892 (unknown [58.251.74.232])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id C66573804F9;
        Fri,  2 Apr 2021 16:43:49 +0800 (CST)
From:   <changfengnan@vivo.com>
To:     "'Andreas Dilger'" <adilger@dilger.ca>
Cc:     "'Theodore Y. Ts'o'" <tytso@mit.edu>,
        "'Ext4 Developers List'" <linux-ext4@vger.kernel.org>
References: <20210329035800.648-1-changfengnan@vivo.com> <000801d72770$d3f4b890$7bde29b0$@vivo.com> <C68A6772-93DE-49E4-8C33-0AF480B4DC3F@dilger.ca>
In-Reply-To: <C68A6772-93DE-49E4-8C33-0AF480B4DC3F@dilger.ca>
Subject: =?utf-8?Q?=E7=AD=94=E5=A4=8D:_=5BPATCH=5D_ext4:_fix_error_code?=
        =?utf-8?Q?_in_ext4=5Fcommit=5Fsuper?=
Date:   Fri, 2 Apr 2021 16:43:49 +0800
Message-ID: <001801d7279c$4d851df0$e88f59d0$@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKGikBhgiQAULD/1R54Z6dLmieg4wKxp9ylAmuttrIBOyE5Ew==
Content-Language: zh-cn
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSEtJGUsaT0tLSk5MVkpNSkxITkhLSEtLSktVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K0k6IRw6PD8OTyoZDh4IESxC
        GkMwCjdVSlVKTUpMSE5IS0hLSUJCVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOSlVMT1VJSElZV1kIAVlBT0xCTDcG
X-HM-Tid: 0a7891c0b928d994kuwsc66573804f9
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for your advice, We did found this problem during code review.
I will revise it according to your opinion.

-----邮件原件-----
发件人: Andreas Dilger <adilger@dilger.ca>
发送时间: 2021年4月2日 15:58
收件人: changfengnan@vivo.com
抄送: Theodore Y. Ts'o <tytso@mit.edu>; Ext4 Developers List 
<linux-ext4@vger.kernel.org>
主题: Re: [PATCH] ext4: fix error code in ext4_commit_super

On Apr 1, 2021, at 9:32 PM, <changfengnan@vivo.com> <changfengnan@vivo.com> 
wrote:
>
> Is there any problem with this patch? I did not see a reply, please
> let me know if there is a problem. Thanks

It's only been a few days since the patch was first posted, so nobody has 
had a chance to review it yet.  The patch looks "obviously correct" at first 
glance, but often changing code is not as obvious as first expected.
Also, is "-EINVAL" the best code here?  For "block_device_ejected()" it 
might be more clear to return "-ENODEV" so that it prints "No such device"
instead of "Invalid argument" in userspace.

> 发件人: Fengnan Chang <changfengnan@vivo.com>
> 发送时间: 2021年3月29日 11:58
> 收件人: tytso@mit.edu; adilger.kernel@dilger.ca;
> linux-ext4@vger.kernel.org
>
> We should set the error code when ext4_commit_super check argument failed.

It would be useful if this also described how this problem was hit, or what 
caused this issue to be seen/fixed.  "Found while reviewing code"
is OK, if that is the case, or "crashed during mount when ejecting a floppy 
disk", or whatever.  That makes it more clear how important the bug fix is 
to be landed and backported.

It would also be useful to include a "Fixes:" label to show which patch 
caused the problem, and help decide which stable kernels need this patch.
From running "git blame fs/ext4/super.c" appears that commit 2d01ddc86606
("ext4: save error info to sb through journal if available") introduced the 
problem, but it seems like that patch only copied it from older code.
However, further digging shows commit c4be0c1dc4cdc ("filesystem freeze:
add error handling of write_super_lockfs/unlockfs") added this particular 
code (error = 0; return error).  Before that time, no error was returned 
from this function at all, so the commit message should include:

Fixes: c4be0c1dc4cdc ("filesystem freeze: add error handling of 
write_super_lockfs/unlockfs")

Cheers, Andreas

> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> ---
> fs/ext4/super.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c index
> 03373471131c..5440b8ff86a8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5501,7 +5501,7 @@ static int ext4_commit_super(struct super_block
> *sb, int sync)
> 	int error = 0;
>
> 	if (!sbh || block_device_ejected(sb))
> -		return error;
> +		return -EINVAL;
>
> 	/*
> 	 * If the file system is mounted read-only, don't update the
> --
> 2.29.0
>
>
>


Cheers, Andreas








