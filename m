Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADECC443A8F
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 01:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhKCArJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Nov 2021 20:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhKCArI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Nov 2021 20:47:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C703BC061714
        for <linux-ext4@vger.kernel.org>; Tue,  2 Nov 2021 17:44:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so132363pjb.1
        for <linux-ext4@vger.kernel.org>; Tue, 02 Nov 2021 17:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=vkIa9py2wYzysbsQBk92Ij5tn3ORckNOy2WjSUHcTcE=;
        b=V2vbVzNCiGiDqGlMMfYPJmQj7skCHWixY+65BEFygL4nYE8G6krGfIoRWfll44O/RW
         HiJwHXr9kdJH+DKOpdtbnwCSj1Pm5vksZ6TqNHlIJJKrz7ll1BhOtz1088yVw733Rodc
         0yF0CnE4nGfnsed224oz9RYLVY89m3B4EnRMZ6SvcQMxiAe9K5cSuTvLj6EnLtFrs/lN
         r9RzdmeFCPqhC4zHCVqVj5DvVTwERINcj7BAAbVpVopI6c+JSVHfV/wZ6v1QNoMKX4DI
         7pZvLxAr6/CI7tMk5QDBxJYgBXO/LL805G3v5NIqfVDNckDW1YTfq87KoXnP0LvIeTcV
         N86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=vkIa9py2wYzysbsQBk92Ij5tn3ORckNOy2WjSUHcTcE=;
        b=NBuZPG9d94alXr9DTECGi9nDFLLERApI2zV5nPGuyU9LIUu9kyGjT3VvVYlV8HIkZQ
         8122YmrN8nvVjdOBLOhZkQVl4pPY8SkLuNqUxtxXI3ptorSRdNmGvV4sdZuH4ZMHbVny
         3UBgkFGbTDjqDOSCEARbgGXd4T9aDByPbHqUGUaZR1nlg5+g3mP71/Jiz7Att0Xw8pXy
         x/0+ErcJtBKGQVKw/I8DsB7JKUjQuVQ1mBy1dtTKT+Erp2fG+MqIEhvaTpUlPjn6Qg1j
         cUorJgMn29bKltTZQj2TosIHh+ZeJultH1fwrqpSPqy8X79G5sSbOHmXfzNBEtCZUtC8
         /1DA==
X-Gm-Message-State: AOAM531Xpm4fqOWkVfcU35f8Gz1IcuhAdEC/w7Ra1/8drQIkEOqf/IrI
        eAGNzl890yWxhuTjo3wWmtrS1g==
X-Google-Smtp-Source: ABdhPJz1+S2zjukXv81B4jIee6GkPaOEuNVJ99FSld9AhN5Jjq84ygIRUEdCIbfcqDb72kteaqRphg==
X-Received: by 2002:a17:903:18b:b0:141:eda2:d5fa with SMTP id z11-20020a170903018b00b00141eda2d5famr15079851plg.63.1635900272098;
        Tue, 02 Nov 2021 17:44:32 -0700 (PDT)
Received: from smtpclient.apple (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id g3sm310946pfv.195.2021.11.02.17.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 17:44:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] ext4: Allow to change s_last_trim_minblks via sysfs
Date:   Tue, 2 Nov 2021 16:44:30 -0800
Message-Id: <5E30A795-F9C1-4865-8703-75940F918A88@dilger.ca>
References: <20211102141902.9808-1-lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        Laurent GUERBY <laurent@guerby.net>
In-Reply-To: <20211102141902.9808-1-lczerner@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
X-Mailer: iPhone Mail (19B74)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Nov 2, 2021, at 06:19, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> =EF=BB=BFExt4 has an optimization mechanism for batched disacrd (FITRIM) t=
hat
> should help speed up subsequent calls of FITRIM ioctl by skipping the
> groups that were previously trimmed. However because the FITRIM allows
> to set the minimum size of an extent to trim, ext4 stores the last
> minimum extent size and only avoids trimming the group if it was
> previously trimmed with minimum extent size equal to, or smaller than
> the current call.
>=20
> There is currently no way to bypass the optimization without
> umount/mount cycle. This becomes a problem when the file system is
> live migrated to a different storage, because the optimization will
> prevent possibly useful discard calls to the storage.
>=20
> Fix it by exporting the s_last_trim_minblks via sysfs interface which
> will allow us to set the minimum size to the number of blocks larger
> than subsequent FITRIM call, effectively bypassing the optimization.
>=20
> By setting the s_last_trim_minblks to INT_MAX the optimization will be
> effectively cleared regardless of the previous state, or file system
> configuration.
>=20
> For example:
> echo 2147483647 > /sys/fs/ext4/dm-1/last_trim_minblks
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Reported-by: Laurent GUERBY <laurent@guerby.net>

The patch itself looks fine, but it isn't really clear why this field is ato=
mic_t?
There is no particular data integrity needed for this field between threads
and it is not harmful if it is set or read in a racy manner (at most it is s=
et at
the end of ext4_trim_fs() once per filesystem trim).

So it seems like this could be a __u32 (like s_clusters_per_group, which is
the largest possible value it can store)
and avoid the need to add a new type
to the sysfs attribute handling?

Cheers, Andreas


> ---
> v2: Remove unnecessary assignment
>=20
> fs/ext4/sysfs.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>=20
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 2314f7446592..94c86eb8d3cc 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -187,6 +187,9 @@ static struct ext4_attr ext4_attr_##_name =3D {       =
     \
> #define EXT4_RO_ATTR_SBI_ATOMIC(_name,_elname)    \
>    EXT4_ATTR_OFFSET(_name, 0444, pointer_atomic, ext4_sb_info, _elname)
>=20
> +#define EXT4_RW_ATTR_SBI_ATOMIC(_name,_elname)    \
> +    EXT4_ATTR_OFFSET(_name, 0644, pointer_atomic, ext4_sb_info, _elname)
> +
> #define EXT4_ATTR_PTR(_name,_mode,_id,_ptr) \
> static struct ext4_attr ext4_attr_##_name =3D {            \
>    .attr =3D {.name =3D __stringify(_name), .mode =3D _mode },    \
> @@ -245,6 +248,7 @@ EXT4_ATTR(last_error_time, 0444, last_error_time);
> EXT4_ATTR(journal_task, 0444, journal_task);
> EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
> EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
> +EXT4_RW_ATTR_SBI_ATOMIC(last_trim_minblks, s_last_trim_minblks);
>=20
> static unsigned int old_bump_val =3D 128;
> EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
> @@ -295,6 +299,7 @@ static struct attribute *ext4_attrs[] =3D {
> #endif
>    ATTR_LIST(mb_prefetch),
>    ATTR_LIST(mb_prefetch_limit),
> +    ATTR_LIST(last_trim_minblks),
>    NULL,
> };
> ATTRIBUTE_GROUPS(ext4);
> @@ -474,6 +479,14 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>            return ret;
>        *((unsigned long *) ptr) =3D t;
>        return len;
> +    case attr_pointer_atomic:
> +        if (!ptr)
> +            return 0;
> +        ret =3D kstrtoint(skip_spaces(buf), 0, (int *)&t);
> +        if (ret)
> +            return ret;
> +        atomic_set((atomic_t *) ptr, t);
> +        return len;
>    case attr_inode_readahead:
>        return inode_readahead_blks_store(sbi, buf, len);
>    case attr_trigger_test_error:
> --=20
> 2.31.1
>=20
