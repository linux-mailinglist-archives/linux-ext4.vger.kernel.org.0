Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63162F64C
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 14:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbiKRNgR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 08:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242147AbiKRNfz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 08:35:55 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0168EB7D
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:34:04 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id bp26-20020a056820199a00b0049f4e8f2d95so771561oob.12
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paYodXZ3a6+QUiya37jUqplXtzHrY+v30RQlipxjc7Q=;
        b=vjjPYKWIuroLmmMIL3QK0l6Kyd7G9ix5gZnXnHmPOSvtoKNxqqn/4+B9auTmxjv8W0
         UH752gb+GBEMcbTBIUgDUFjO8gIDW/K8XPu24t/hWcFJsQqKkzYzxYthGY442Qrn/36I
         cNQDx/6CBt5C2t5Wcsv6y3QwLqsHEe8/uKc6ncr0Xsf86TFTMg5+kisOjalntbpFjSR3
         TFZmORTWFxP4zJ6CUnEJQnzDd7szQWtR7x8IjVmW4K6qzhuCcOFuAlitJxlob9R7ztfI
         pxhEkWjIAWdPHrbLOdiBqXS4gCIMFmx2MQVn9svz4DIEQDJCoit6smxbuiXyhuwRHtoS
         TiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paYodXZ3a6+QUiya37jUqplXtzHrY+v30RQlipxjc7Q=;
        b=UK4622ojnNBiH2BkXMPor4UMoeWMQBrbQmpDfUGu28FtS+Fc8xQZOv8R1CDCpZZZcV
         q0RkPIt7EY4dzYmBh4mdYnDrbpr8idgfU+Rr+hC0vEiMH0grDq6MwLrtdWNF3JueGqOq
         8tnPzG21bZGbzyqL+KC8xFddTK38oKx3vrpXvvNyjTCWqWHIzvq7zzvMPrZHW1dAobya
         qtNLOdz3u4SWFmCYgN2zLf1scZp/oHAj/A8VnDcgu3ytCO1gqfwvjSSBFuuQ0cEfnz36
         5cv76l8B1cQkNgezNRy1isNemsGqQsnFo76a/eZ8BELKV3PziB0UcdDLEuBT/lcvGkCR
         IYCg==
X-Gm-Message-State: ANoB5pmqhyqsgNDS8RBA3+uqU+LxP/hefzqsntJlS/Epk6C8bTEiHLGE
        9/WsC8mduMqV1vvkijEyPsf6gn2QX19nteuv
X-Google-Smtp-Source: AA0mqf6VWPkbsCW/OJtJYG2QkTSyFmL4yUh5G5KrTVnKtDZG0Wf9m0uBEjzGRLlCu3Tf/K70T1R0QQ==
X-Received: by 2002:a4a:c990:0:b0:475:7520:c3f0 with SMTP id u16-20020a4ac990000000b004757520c3f0mr3446228ooq.40.1668778443006;
        Fri, 18 Nov 2022 05:34:03 -0800 (PST)
Received: from smtpclient.apple ([205.169.26.81])
        by smtp.gmail.com with ESMTPSA id bc6-20020a056820168600b0049be9c3c15dsm1394536oob.33.2022.11.18.05.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:34:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFCv1 06/72] dblist: add dblist merge logic
Date:   Fri, 18 Nov 2022 07:34:01 -0600
Message-Id: <DA9ADCC5-0D03-4C7C-B8BE-8D40A89D1ABA@dilger.ca>
References: <99ecce2af8609cc7bbe79de273472dcb42cca8f5.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
In-Reply-To: <99ecce2af8609cc7bbe79de273472dcb42cca8f5.1667822611.git.ritesh.list@gmail.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Mailer: iPhone Mail (19H12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Nov 7, 2022, at 06:22, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote=
:
>=20
> =EF=BB=BFFrom: Li Xi <lixi@ddn.com>
>=20
> This adds dblist merge logic.
>=20
> TODO: Add a unit test for core operations of dblist. Currently there is
> no such test for this.
>=20
> Signed-off-by: Li Xi <lixi@ddn.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/dblist.c | 36 ++++++++++++++++++++++++++++++++++++
> lib/ext2fs/ext2fs.h |  1 +
> 2 files changed, 37 insertions(+)
>=20
> diff --git a/lib/ext2fs/dblist.c b/lib/ext2fs/dblist.c
> index bbdb221d..5568b8ec 100644
> --- a/lib/ext2fs/dblist.c
> +++ b/lib/ext2fs/dblist.c
> @@ -119,6 +119,42 @@ errcode_t ext2fs_copy_dblist(ext2_dblist src, ext2_db=
list *dest)
>    return 0;
> }
>=20
> +/*
> + * Merge a directory block list @src to @dest
> + */
> +errcode_t ext2fs_merge_dblist(ext2_dblist src, ext2_dblist dest)
> +{
> +   unsigned long long src_count =3D src->count;
> +   unsigned long long dest_count =3D dest->count;
> +   unsigned long long size =3D src_count + dest_count;
> +   size_t size_entry =3D sizeof(struct ext2_db_entry2);
> +   struct ext2_db_entry2 *array, *array2;
> +   errcode_t retval;
> +
> +   if (src_count =3D=3D 0)
> +       return 0;
> +
> +   if (src->sorted || (dest->sorted && dest_count !=3D 0))
> +       return EINVAL;
> +
> +   retval =3D ext2fs_get_array(size, size_entry, &array);
> +   if (retval)
> +       return retval;
> +
> +   array2 =3D array;
> +   memcpy(array, src->list, src_count * size_entry);
> +   array +=3D src_count;
> +   memcpy(array, dest->list, dest_count * size_entry);
> +   ext2fs_free_mem(&dest->list);
> +
> +   dest->list =3D array2;
> +   dest->count =3D src_count + dest_count;
> +   dest->size =3D size;
> +   dest->sorted =3D 0;
> +
> +   return 0;
> +}
> +
> /*
>  * Close a directory block list
>  *
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 18dddc2c..443f93d2 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -1143,6 +1143,7 @@ extern errcode_t ext2fs_add_dir_block(ext2_dblist db=
list, ext2_ino_t ino,
>                      blk_t blk, int blockcnt);
> extern errcode_t ext2fs_add_dir_block2(ext2_dblist dblist, ext2_ino_t ino,=

>                       blk64_t blk, e2_blkcnt_t blockcnt);
> +extern errcode_t ext2fs_merge_dblist(ext2_dblist src, ext2_dblist dest);
> extern void ext2fs_dblist_sort(ext2_dblist dblist,
>                   EXT2_QSORT_TYPE (*sortfunc)(const void *,
>                               const void *));
> --=20
> 2.37.3
>=20
