Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03C7390139
	for <lists+linux-ext4@lfdr.de>; Tue, 25 May 2021 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhEYMr2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 May 2021 08:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbhEYMr2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 May 2021 08:47:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1385C061574
        for <linux-ext4@vger.kernel.org>; Tue, 25 May 2021 05:45:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e2so31605506ljk.4
        for <linux-ext4@vger.kernel.org>; Tue, 25 May 2021 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kTjq/pkRY/mIOTgmZf7zbslMPwp6yZoNctJhXo+MN8Y=;
        b=Vm+YvySVXDSVRV9hQJHbpxSlW2ARj/lTB24beWtGS3b+MWldlSYGPsPBx2TxFS+0KR
         Zbisxeb1zL05vMzksQBMgS06Jpi6RnEK3FnkAEW7RNCrGIOh6IpM1GT5gRNxgNuYjXf6
         XS9uSL8bVYq+5BiMMZSz6d1llyTi5wBB+e/8XlR+s3CNvZaDFW4K49EPvBUDogC4StY4
         TofRcLA4tlND0Ly/cY4+26KqCqC9AgAQb58xkz11DaVDsXAb4zGISpwzcXxL3blg3eo3
         B17RuCAAUkyEPN8pwTLIucxuxwfwZ9wfFasG6g9ukzq9RDvK0DmM9K1iB5hEZBQ3Ii5Z
         +7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kTjq/pkRY/mIOTgmZf7zbslMPwp6yZoNctJhXo+MN8Y=;
        b=I5pWRcEysN/m1Y7WSA/mqLjA+3Iv+A5v0DtW+tDixMlWfpckuzguT+QbhSC0+QqBEM
         tkiVeslwWR32P97mZ2nT2jVL/RuIQsrhk2XTfXzsBOiBB1oyVTVeZUZGka2mnpRLm1xo
         qcvdiVJUktwvJoh//TUNWtCUUZIhiyp/ab/ziai7wrVFhqY26f6ZwXf7Yse07KzRoxtR
         WyPsjya8xlodq+Wlcb3+wehWwgUo7qbRHLVoMSJxH8o3rPHSEH3XA+pqBXveUTnYGlre
         s2F+FWUf8N3Z1FwZwx81KnEHJFKpSXMawMNVX5dzq05j88GGfALOAQerxKhKeW5Va9Yl
         r1pg==
X-Gm-Message-State: AOAM530x4SG5QAuoH/Ci9tTFJyWhQfFJ+KzY9WDjDn2CdlU2HtDayZPb
        4A0Hbj0BfmWT0gtwMVpD2YYbTA6+oyD6nuSx
X-Google-Smtp-Source: ABdhPJwBkjr8TQGnSm2eKc8PidECIVgiZ7zVEcJq7raVThJ0ZDCE2Xr4WaduB868BSqlZhAQOfbRsQ==
X-Received: by 2002:a2e:995:: with SMTP id 143mr13951557ljj.240.1621946754122;
        Tue, 25 May 2021 05:45:54 -0700 (PDT)
Received: from [192.168.2.192] ([83.234.50.67])
        by smtp.gmail.com with ESMTPSA id q66sm289553ljb.83.2021.05.25.05.45.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 05:45:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.20\))
Subject: Re: [PATCH 10/12] hashmap: change return value type of,
 ext2fs_hashmap_add()
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <13880683-11b1-395a-05d0-f9076cca1672@huawei.com>
Date:   Tue, 25 May 2021 15:45:39 +0300
Cc:     linux-ext4@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECE8BAEA-EDA7-472D-9163-ABD0709F91F7@gmail.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
 <13880683-11b1-395a-05d0-f9076cca1672@huawei.com>
To:     Wu Guanghao <wuguanghao3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.20)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On 24 May 2021, at 14:25, Wu Guanghao <wuguanghao3@huawei.com> wrote:
>=20
> In ext2fs_hashmap_add(), new entry is allocated by calling
> malloc(). If malloc() return NULL, it will cause a
> segmentation fault problem.
>=20
> Here, we change return value type of ext2fs_hashmap_add()
> from void to int. If allocating new entry fails, we will
> return 1, and the callers should also verify the return
> value of ext2fs_hashmap_add().
>=20
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> ---
> contrib/android/base_fs.c | 12 +++++++++---
> lib/ext2fs/fileio.c       | 11 +++++++++--
> lib/ext2fs/hashmap.c      | 12 ++++++++++--
> lib/ext2fs/hashmap.h      |  4 ++--
> 4 files changed, 30 insertions(+), 9 deletions(-)
>=20
> diff --git a/contrib/android/base_fs.c b/contrib/android/base_fs.c
> index 652317e2..d3e00d18 100644
> --- a/contrib/android/base_fs.c
> +++ b/contrib/android/base_fs.c
> @@ -110,10 +110,16 @@ struct ext2fs_hashmap *basefs_parse(const char =
*file, const char *mountpoint)
> 	if (!entries)
> 		goto end;
>=20
> -	while ((entry =3D basefs_readline(f, mountpoint, &err)))
> -		ext2fs_hashmap_add(entries, entry, entry->path,
> +	while ((entry =3D basefs_readline(f, mountpoint, &err))) {
> +		err =3D ext2fs_hashmap_add(entries, entry, entry->path,
> 				   strlen(entry->path));
> -
> +		if (err) {
> +			free_base_fs_entry(entry);
> +			fclose(f);
> +			ext2fs_hashmap_free(entries);
> +			return NULL;
> +		}
> +	}
> 	if (err) {
> 		fclose(f);
> 		ext2fs_hashmap_free(entries);
> diff --git a/lib/ext2fs/fileio.c b/lib/ext2fs/fileio.c
> index a0b5d971..b86951d9 100644
> --- a/lib/ext2fs/fileio.c
> +++ b/lib/ext2fs/fileio.c
> @@ -475,8 +475,15 @@ errcode_t ext2fs_file_write(ext2_file_t file, =
const void *buf,
>=20
> 			if (new_block) {
> 				new_block->physblock =3D =
file->physblock;
> -				ext2fs_hashmap_add(fs->block_sha_map, =
new_block,
> -					new_block->sha, =
sizeof(new_block->sha));
> +				int ret =3D =
ext2fs_hashmap_add(fs->block_sha_map,
> +						new_block, =
new_block->sha,
> +						sizeof(new_block->sha));
> +				if (ret) {
> +					retval =3D EXT2_ET_NO_MEMORY;
> +					free(new_block);
> +					new_block =3D NULL;

There is no need to set new_block to NULL here.. new_block is a local =
variable and the function returns after "fail" label.
Same for blocks above which also jump to the =E2=80=9Cfail=E2=80=9D =
label.
> +					goto fail;
> +				}
> 			}
>=20
> 			if (bmap_flags & BMAP_SET) {
> diff --git a/lib/ext2fs/hashmap.c b/lib/ext2fs/hashmap.c
> index ffe61ce9..7278edaf 100644
> --- a/lib/ext2fs/hashmap.c
> +++ b/lib/ext2fs/hashmap.c
> @@ -36,6 +36,9 @@ struct ext2fs_hashmap *ext2fs_hashmap_create(
> {
> 	struct ext2fs_hashmap *h =3D calloc(sizeof(struct =
ext2fs_hashmap) +
> 				sizeof(struct ext2fs_hashmap_entry) * =
size, 1);
> +	if (!h)
> +		return NULL;
> +
> 	h->size =3D size;
> 	h->free =3D free_fct;
> 	h->hash =3D hash_fct;
> @@ -43,12 +46,15 @@ struct ext2fs_hashmap *ext2fs_hashmap_create(
> 	return h;
> }
>=20
> -void ext2fs_hashmap_add(struct ext2fs_hashmap *h, void *data, const =
void *key,
> -			size_t key_len)
> +int ext2fs_hashmap_add(struct ext2fs_hashmap *h,
> +		void *data, const void *key, size_t key_len)
> {
> 	uint32_t hash =3D h->hash(key, key_len) % h->size;
> 	struct ext2fs_hashmap_entry *e =3D malloc(sizeof(*e));
>=20
> +	if (!e)
> +		return -1;
> +
> 	e->data =3D data;
> 	e->key =3D key;
> 	e->key_len =3D key_len;
> @@ -62,6 +68,8 @@ void ext2fs_hashmap_add(struct ext2fs_hashmap *h, =
void *data, const void *key,
> 	h->first =3D e;
> 	if (!h->last)
> 		h->last =3D e;
> +
> +	return 0;
> }
>=20
> void *ext2fs_hashmap_lookup(struct ext2fs_hashmap *h, const void *key,
> diff --git a/lib/ext2fs/hashmap.h b/lib/ext2fs/hashmap.h
> index dcfa7455..0c09d2bd 100644
> --- a/lib/ext2fs/hashmap.h
> +++ b/lib/ext2fs/hashmap.h
> @@ -27,8 +27,8 @@ struct ext2fs_hashmap_entry {
> struct ext2fs_hashmap *ext2fs_hashmap_create(
> 				uint32_t(*hash_fct)(const void*, =
size_t),
> 				void(*free_fct)(void*), size_t size);
> -void ext2fs_hashmap_add(struct ext2fs_hashmap *h, void *data, const =
void *key,
> -			size_t key_len);
> +int ext2fs_hashmap_add(struct ext2fs_hashmap *h,
> +		       void *data, const void *key,size_t key_len);
> void *ext2fs_hashmap_lookup(struct ext2fs_hashmap *h, const void *key,
> 			    size_t key_len);
> void *ext2fs_hashmap_iter_in_order(struct ext2fs_hashmap *h,
> --=20

Best regards,
Artem Blagodarenko

