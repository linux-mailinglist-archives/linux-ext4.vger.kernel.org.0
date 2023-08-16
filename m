Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1717977D9C4
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 07:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbjHPFcL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 01:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbjHPFbl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 01:31:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5057B1FC7;
        Tue, 15 Aug 2023 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.at;
 s=s31663417; t=1692163895; x=1692768695; i=g.ottinger@gmx.at;
 bh=qxO18DwXZii86eJnCMKp0O3O9rqlhobuQS8bj+UVmZo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RW8m7fdfMGVyv35MzItb6puntOQz9APD2dSJvVr5VxW0qcDgeZRjK+KPUoQzB/VGmzOqB9t
 66OqrSsGKkHxC2LIeSH+Yt1oJwQWBYe1YDQb5RvPJboOpbAWE4Dq6IV04QN0e99A5AAGywyPc
 1KMc68Xy2hVRGzvijKUU0otyppqEVCGqGixvHREYsSEPosYnEnBwSMoKTYAOcyzuLotmBDUG4
 k97PeUjLdxYF9WBYyXhE/wggN+xHv1ioZepXsT0RyegT7oFL+nhnifBlhrcf0YraPhuL8ry1T
 kvIYgmHO7IpOHJ8SSPSZ3ZfO17HPPtl89EPe2goY6BXOhAUP7ZZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.153.228] ([89.144.221.196]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9X9-1qfFnb3Maf-009Adu; Wed, 16
 Aug 2023 07:31:34 +0200
Message-ID: <e6dff0e9-9f08-2684-2bba-74570c3655a8@gmx.at>
Date:   Wed, 16 Aug 2023 07:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ext2: fix datatype of block number in
 ext2_xattr_set2()
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816052104.3374-1-g.ottinger@gmx.at>
Content-Language: en-US
From:   Georg Ottinger <g.ottinger@gmx.at>
In-Reply-To: <20230816052104.3374-1-g.ottinger@gmx.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VXnnEnRGVIpDmN2hJI7YTzvkW1mwt/58ECZMtrdD5Ln8tMY1LTf
 +sWQC40kI/PGiLZTfaYoxhUhYqd+GajnrSVwbM1zikzbrv9pfbuJMAj41YK4OyBw2i6hdkA
 /4oV2q1zb5/OSUpzWaeSIaCtvQl6Ta3+p7BnsJ2vwNKKiyARLAkOvHtKMDJvYTjy89Pr0iH
 SzUW2QadJtV2pDSFyCjkQ==
UI-OutboundReport: notjunk:1;M01:P0:1bzbiHE/zOQ=;rnBHGKcUeZ9ab0gYdKNJjhNv6fP
 fm188aaH9esLg8K8ZANmNCIk0h0/SNDRZZiqhTv1giBqIgQWdnDGNcBy7bF6lYE9p4vOAllV7
 rKjakE7u/57CiKwrPpEYPEkSadO9B3d/f/o5Izov/d4u5E1mvnY/aE8EY/3dhoiUmV3NO/D9j
 MdeMixwNVdumZsWeYZdLN2v1gXPKcKwxFXzZvPaaIeOSxp63dWUr+sYajUV/PV4bfUjIQzPRc
 xkpESrbZYo1vjkSC8dH1dnSoGGw1VlPG+Hb6d30/epGFFD+8jeXHwG/AhCX/JJQ4KI2gQ90fp
 9pxpk2aHK1Zf8PceygasuGY4PXFvQDDiv9XDWcJgRy64i/CrKVGKHQS5Rj13XH9RoRjoLLW/W
 jwgowk5VhSwVgfuTrGv8cuz08zSWCM3sOFoSvnWrM9Ic7BwfeNpbBr9g4rw0J8TPIIA5xoxux
 mEOGIIbcrxwmFd6x7yHvqMwDRv+vIh2aMKJtZ80t4w4+dGRTcIuYubHJX1FTPFNZDRYmGSEEa
 N9xLWo3FeU9T2msXAej1ZzC9TT0l1m1VxftdtIq0/j/cMdkb3752gpkBGLSI8tlyQW8dcZYLh
 7eo4j1XNf7fCnReamlix09POTbAdnjFYZimwDbWjeSijxEjBy9llcvRcSC89gd3rfAGkm6LhG
 f22Sv+NS+ADFZ/zBQ0j11hxeUIMENoRWNooX1do1ZRYUYkXLXA8DHHxrZttgrNKavP+l2Y9zE
 OBXchj9JYVFNH942nkINjs8L6Q+1daa2W1QoJaFmyH9lXD3Sp58CozAumagxPoAI1M/U8TXf/
 gQ4SNzk7tRhS4sIwYO8UkkxiG7roVIqpalQdDwgKGYEE0tsouX6NQy5q92fM4elShM+4qlC7b
 3sOzJcTlL2AVCjVFj7ALNj5Gthp9dC5jSSQdj7W0PqggPYMoAaWB4jF+4cpwRC/HNBrexnG4R
 NpDH2zK6O/GsiIW/WGhDm9okfOk=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I missed the proper format string for the debug message.

answering Andreas question - I did check the remaining calls to
ext2_new_block(), ext2_new_blocks() and ext2_free_blocks() within the
ext2 directory - here the block argument is either unsigned long or
ext2_fsblk_t (which is a typedef to unsigend long) - However I want to
mention that the use of unsigned long / ext2_fsblk_t is inconsistent. I
guess that ext2_fsblk_t should be the prefered data type.

Concerning the fs corruption - thanks Jan for your input.

The server is an old Centos6 / RHEL6 Machine, and as a workaround - i
resized the partition to 8180GB - Unfortunately I am unsure if I find
time to investigate this issue further - I just did a quick look at the
kernel source and the Bug was kind of obvious ...


On 16.08.23 07:21, Georg Ottinger wrote:
> I run a small server that uses external hard drives for backups. The
> backup software I use uses ext2 filesystems with 4KiB block size and
> the server is running SELinux and therefore relies on xattr. I recently
> upgraded the hard drives from 4TB to 12TB models. I noticed that after
> transferring some TBs I got a filesystem error "Freeing blocks not in
> datazone - block =3D 18446744071529317386, count =3D 1" and the backup
> process stopped. Trying to fix the fs with e2fsck resulted in a
> completely corrupted fs. The error probably came from ext2_free_blocks()=
,
> and because of the large number 18e19 this problem immediately looked
> like some kind of integer overflow. Whereas the 4TB fs was about 1e9
> blocks, the new 12TB is about 3e9 blocks. So, searching the ext2 code,
> I came across the line in fs/ext2/xattr.c:745 where ext2_new_block()
> is called and the resulting block number is stored in the variable block
> as an int datatype. If a block with a block number greater than
> INT32_MAX is returned, this variable overflows and the call to
> sb_getblk() at line fs/ext2/xattr.c:750 fails, then the call to
> ext2_free_blocks() produces the error.
>
> Signed-off-by: Georg Ottinger <g.ottinger@gmx.at>
> ---
>   fs/ext2/xattr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 8906ba479..89517937d 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -742,10 +742,10 @@ ext2_xattr_set2(struct inode *inode, struct buffer=
_head *old_bh,
>   			/* We need to allocate a new block */
>   			ext2_fsblk_t goal =3D ext2_group_first_block_no(sb,
>   						EXT2_I(inode)->i_block_group);
> -			int block =3D ext2_new_block(inode, goal, &error);
> +			ext2_fsblk_t block =3D ext2_new_block(inode, goal, &error);
>   			if (error)
>   				goto cleanup;
> -			ea_idebug(inode, "creating block %d", block);
> +			ea_idebug(inode, "creating block %lu", block);
>
>   			new_bh =3D sb_getblk(sb, block);
>   			if (unlikely(!new_bh)) {
> --
> 2.17.1
>

