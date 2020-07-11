Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B9F21C309
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Jul 2020 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgGKH2Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 Jul 2020 03:28:25 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17107 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbgGKH2Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 11 Jul 2020 03:28:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594452487; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=WKWE3bVeXz5BUZpTqZpuy0JcdOxKuW14NTl/NoW7Ec9sZYAihZmwAoTE/PIEFexsXNwe8KAATX/3JcILqi9rxQ1ZnV7eC4+HxhVauYugd+HmBDDLT0SSYdoHVhCKVi34yugL5xJo2g2d9/Zi+dt54b6ujCYZZld+oXg8rd0yPSw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1594452487; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=LlxI+xhhbaNqR3A672B1fiq0MKfW9jkWMb2zP3rGVK0=; 
        b=K94aft54caCskHniBSpp6phkuWnxrdpCisy9iJkxgalqlcl9PEiJDPIeToDEvpNX6AigyLcgb3R6qHtw3yIZAFVZNyh9X1jq+GI0zFdzYAZo3UumndAqoYSQZV2jG35Th9jCMW/ZINyEPyfRRtGLT9mnEuMjf8C2UePrZ/wtXO8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1594452487;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=LlxI+xhhbaNqR3A672B1fiq0MKfW9jkWMb2zP3rGVK0=;
        b=UKm5W7Vrv/gwXyVd6LkGxQOQHfg8LK0yo7rGQ1vWAoVbVPiNo0bugqjktaihjnu3
        m3Jfo247fd1z4pWoNsIIX9zQKUKFeP0pAofLDjSrMVqKeorU544p10KGBOUGjPaY5ed
        JXJFxbUr1hNTZ98bt7GZIpsZtrhVxlO1Zw6E83hs=
Received: from [10.0.0.5] (113.87.90.223 [113.87.90.223]) by mx.zoho.com.cn
        with SMTPS id 1594452485309823.4562675062915; Sat, 11 Jul 2020 15:28:05 +0800 (CST)
Subject: Re: [PATCH] ext2: initialize quota info in ext2_xattr_set()
To:     Ritesh Harjani <riteshh@linux.ibm.com>, jack@suse.com
Cc:     linux-ext4@vger.kernel.org
References: <20200626054959.114177-1-cgxu519@mykernel.net>
 <20200708105202.7AE73A405F@b06wcsmtp001.portsmouth.uk.ibm.com>
From:   Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <38909abd-c180-8e04-216c-24755d1ca582@mykernel.net>
Date:   Sat, 11 Jul 2020 15:27:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708105202.7AE73A405F@b06wcsmtp001.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

=E5=9C=A8 7/8/2020 6:52 PM, Ritesh Harjani =E5=86=99=E9=81=93:
>
>
> On 6/26/20 11:19 AM, Chengguang Xu wrote:
>> In order to correctly account/limit space usage, should initialize
>> quota info before calling quota related functions.
>
> How did you encounter the problem?
> Any test case got hit?

I found the issue by code inspecting when I was learning mbcache logic.

Thanks,
cgxu

>
>>
>> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>
> LGTM, feel free to add
> Reviewed-by: Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
>
>> ---
>> =C2=A0 fs/ext2/xattr.c | 3 +++
>> =C2=A0 1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
>> index 943cc469f42f..913e5c4921ec 100644
>> --- a/fs/ext2/xattr.c
>> +++ b/fs/ext2/xattr.c
>> @@ -437,6 +437,9 @@ ext2_xattr_set(struct inode *inode, int=20
>> name_index, const char *name,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name_len =3D strlen(name);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (name_len > 255 || value_len > sb->s_b=
locksize)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ERANGE;
>> +=C2=A0=C2=A0=C2=A0 error =3D dquot_initialize(inode);
>> +=C2=A0=C2=A0=C2=A0 if (error)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 down_write(&EXT2_I(inode)->xattr_sem);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (EXT2_I(inode)->i_file_acl) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The inode alre=
ady has an extended attribute block. */
>>


