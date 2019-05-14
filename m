Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688B81CC00
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2019 17:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfENPhE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 May 2019 11:37:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46616 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENPhE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 May 2019 11:37:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so12985545ljk.13
        for <linux-ext4@vger.kernel.org>; Tue, 14 May 2019 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a2qenEH0pwGDHD9nQd1+JKF/YJUUUW+eCJrK4xUw5jg=;
        b=PVlb0XjlN8SL7TCyD6ffyoKOy/I3o+2eZ0/dkhUwblBa0QDb6GvjwgKWGKaTV/B9wt
         F2UE10WwcEvWgz9S2xrgVM1PkW6dNVqRowU1tzCeIdAUx1JF0R2tkaaymgmUT8BV0HYm
         hsIu5+dIYWJNmgMUrq/0iSS+8MQByFJIj5ZrTzaUvJxBWh80/wOBV95lsvsDDak5szGw
         mHAhqCnRM1XN1aOJTZ6HR6B/vCqndfrDvQeQ+sZqWMOd+umvpXMl9UQqyTyOfLMBz9Tn
         8nzadJCv39SPRsLnKCC1uucrpk/YbhFhkgx0d2uOiWhzQyhWmnC40tYtWRTdU2Zz3LX6
         g34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a2qenEH0pwGDHD9nQd1+JKF/YJUUUW+eCJrK4xUw5jg=;
        b=c3YpZTUj95HWLr1fXGZDnJPgwtZsGQUac7/AQao0Ro8EAqRHC9OE/HIEz6CWt4n7Yy
         1Ctl/jcPk0Qcs0VYOOfgQRRenYHZxU2sUOWeMHHv1IB2N+0tvUgJtccrnng/pgPNsYvV
         SFDqlsk81zo5zpU5wnktasusKnb88UGOW9tOwvxtwl6w7vqz9vLYbAsri2ad4kk+rgMa
         WjgEmWj8ZBFGTCCl5e4rPeFD9YbBLtFfe9kRA20IhnnnQ3IOuPpEqacK8O/JWX473iWe
         5Mw4l4ZCU1eCdnuZFW+fJz2i4qtPZ3b6cCefKGIAmJm48Rf2czqhFPXUAuB3LFzVOIEm
         uSZg==
X-Gm-Message-State: APjAAAVhMUYmARvc1CuaV2mW4BT56dUXAoHCMGNZOArdgslWEUjqvr7t
        qvLjrGJvHyflaAAptHtQwpNxKg==
X-Google-Smtp-Source: APXvYqy63/wxyv3+e7BWT7kN9meVWvPcpS9gcu/9oBQURgUNci7PXX4zGWYlsC8RQR0zfz1fVhnEXg==
X-Received: by 2002:a2e:8849:: with SMTP id z9mr1381140ljj.164.1557848222524;
        Tue, 14 May 2019 08:37:02 -0700 (PDT)
Received: from [192.168.3.100] ([95.174.108.185])
        by smtp.gmail.com with ESMTPSA id j1sm785066lja.17.2019.05.14.08.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 08:37:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 2/2] ext2: introduce helper for xattr entry validation
From:   Alexey Lyashkov <umka@cloudlinux.com>
In-Reply-To: <3D6EA2A3-CC61-4243-982F-E53305EA0231@dilger.ca>
Date:   Tue, 14 May 2019 18:37:00 +0300
Cc:     Chengguang Xu <cgxu519@zoho.com.cn>, Jan Kara <jack@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8168A2C-AA09-422D-955D-5C0DD6F32142@cloudlinux.com>
References: <20190513224042.23377-1-cgxu519@zoho.com.cn>
 <20190513224042.23377-2-cgxu519@zoho.com.cn>
 <3D6EA2A3-CC61-4243-982F-E53305EA0231@dilger.ca>
To:     Andreas Dilger <adilger@dilger.ca>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I think this patch need to be refined.

>> if (entry->e_value_block !=3D 0
duplicated with check bellow ext2_xattr_entry_valid checks.




> 14 =D0=BC=D0=B0=D1=8F 2019 =D0=B3., =D0=B2 18:32, Andreas Dilger =
<adilger@dilger.ca> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>=20
> On May 13, 2019, at 4:40 PM, Chengguang Xu <cgxu519@zoho.com.cn> =
wrote:
>>=20
>> Introduce helper function ext2_xattr_entry_valid()
>> for xattr entry validation and clean up the entry
>> check ralated code.
>>=20
>> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
>=20
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>=20
>> ---
>> v1->v2:
>> - Pass end offset instead of inode to ext2_xattr_entry_valid()
>> - Change signed-off mail address.
>>=20
>> fs/ext2/xattr.c | 21 +++++++++++++++++----
>> 1 file changed, 17 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
>> index db27260d6a5b..d11c83529514 100644
>> --- a/fs/ext2/xattr.c
>> +++ b/fs/ext2/xattr.c
>> @@ -144,6 +144,20 @@ ext2_xattr_header_valid(struct ext2_xattr_header =
*header)
>> 	return true;
>> }
>>=20
>> +static bool
>> +ext2_xattr_entry_valid(struct ext2_xattr_entry *entry, size_t size,
>> +		       size_t end_offs)
>> +{
>> +	if (entry->e_value_block !=3D 0)
>> +		return false;
>> +
>> +	if (size > end_offs ||
>> +	    le16_to_cpu(entry->e_value_offs) + size > end_offs)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> /*
>> * ext2_xattr_get()
>> *
>> @@ -217,8 +231,7 @@ ext2_xattr_get(struct inode *inode, int =
name_index, const char *name,
>> 	if (entry->e_value_block !=3D 0)
>> 		goto bad_block;
>> 	size =3D le32_to_cpu(entry->e_value_size);
>> -	if (size > inode->i_sb->s_blocksize ||
>> -	    le16_to_cpu(entry->e_value_offs) + size > =
inode->i_sb->s_blocksize)
>> +	if (!ext2_xattr_entry_valid(entry, size, =
inode->i_sb->s_blocksize))
>> 		goto bad_block;
>>=20
>> 	if (ext2_xattr_cache_insert(ea_block_cache, bh))
>> @@ -483,8 +496,8 @@ ext2_xattr_set(struct inode *inode, int =
name_index, const char *name,
>> 		if (!here->e_value_block && here->e_value_size) {
>> 			size_t size =3D le32_to_cpu(here->e_value_size);
>>=20
>> -			if (le16_to_cpu(here->e_value_offs) + size >
>> -			    sb->s_blocksize || size > sb->s_blocksize)
>> +			if (!ext2_xattr_entry_valid(here, size,
>> +			    inode->i_sb->s_blocksize))
>> 				goto bad_block;
>> 			free +=3D EXT2_XATTR_SIZE(size);
>> 		}
>> --
>> 2.17.2
>>=20
>>=20
>=20
>=20
> Cheers, Andreas
>=20
>=20
>=20
>=20
>=20

