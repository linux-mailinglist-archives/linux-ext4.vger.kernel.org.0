Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6162F619
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 14:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbiKRNbW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 08:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiKRNbV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 08:31:21 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868178C4A0
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:31:19 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id n205so5344198oib.1
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHz0Nc9xRFDikzbKReRE/I4YGqC1pkEJE5elJpVu7Aw=;
        b=3VoftXP17vGPVNHrXcxy/t/1y4vHCX2NjQ6KGBLWYINgb7HMNwH+2eN3FYvbMqd8NG
         x4wMckStS1o8Hqup044ILvFnidlRxdocAZCBduLBTcypN+rKy20BkOeO4jiP05kUaDEN
         YESrWSONG63a8i/LLHhTYthIKa4UHvaauI9jI03K5z+nUl7TBspUdQ4awR99qZaLS3mv
         rIjpiITeaA0GJ6vvRhfO+XlSsmzTayqE/8znjawnNKqYLxuAE0Ij7Dvjwn0PlrXorhOc
         cVfTWnuJ1voBYXf8xN8dcGJD9i6aIkxxW73PhBrUOQt+bJXhUYA+nMAnxV51Ii+n9A2X
         UffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHz0Nc9xRFDikzbKReRE/I4YGqC1pkEJE5elJpVu7Aw=;
        b=fqQtU5MM5RGoAQccQgb4B7Q0+q6CF19VeL+ulY5i13S4Atp+L9Qn/teTIw6qCavPhD
         HvbHf5L3dJ1f58GsQEVQ5dtK5rpBGhKfPdGGEQDMP3mBOUqkB1CfkvGR8F5Vd77VqmN/
         KKIchR1tpfKxwIfbBP8dzdOXiiDDcsCRKDjCF8uG36plYt6VEFRCZXw/Eej46VRG81rx
         iNKscmOPuueiBxD1ODXxj9lIhhxEJnZYxHs+V451HLKTg5Xa/qqdfRyc0AWLDG36r5JW
         LIzC5OOqQfT92GQ7T4fGRKbJfPOl6q7EVNleEOVbjdX5qCAdQgEOAdWzZCGEoKeNYNFE
         2mZg==
X-Gm-Message-State: ANoB5pkJ4jxeU72v7ZxBeakZrbK7Nl6T9KKXkq3KxEiyh1gS42EOXuuQ
        Hg3dIncHaEh2h1qshMDQKIYOgmfSsroBJPYA
X-Google-Smtp-Source: AA0mqf79xpxjzzXXqbIPVyaMdaT8yL58/DmyV/TYRe29WGW/nSxdOkDR8MPH58/9zzMhJk37QX+v6Q==
X-Received: by 2002:a05:6808:3096:b0:355:ebd:8b3a with SMTP id bl22-20020a056808309600b003550ebd8b3amr3385467oib.117.1668778278337;
        Fri, 18 Nov 2022 05:31:18 -0800 (PST)
Received: from smtpclient.apple ([205.169.26.81])
        by smtp.gmail.com with ESMTPSA id r186-20020acac1c3000000b0035a9003b8edsm1363544oif.40.2022.11.18.05.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:31:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFCv1 05/72] badblocks: Add badblocks merge logic
Date:   Fri, 18 Nov 2022 07:31:17 -0600
Message-Id: <A77B6257-E497-46B5-81BC-EDF5FF6C411B@dilger.ca>
References: <01e72f626dcebdb8f0a78b53e4cd093357d82787.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
In-Reply-To: <01e72f626dcebdb8f0a78b53e4cd093357d82787.1667822611.git.ritesh.list@gmail.com>
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
> =EF=BB=BFFrom: Wang Shilong <wshilong@ddn.com>
>=20
> Add badblocks merge logic
>=20
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/badblocks.c | 75 ++++++++++++++++++++++++++++++++++++++++++
> lib/ext2fs/ext2fs.h    |  2 ++
> 2 files changed, 77 insertions(+)
>=20
> diff --git a/lib/ext2fs/badblocks.c b/lib/ext2fs/badblocks.c
> index 345168e0..36794e69 100644
> --- a/lib/ext2fs/badblocks.c
> +++ b/lib/ext2fs/badblocks.c
> @@ -56,6 +56,74 @@ static errcode_t make_u32_list(int size, int num, __u32=
 *list,
>    return 0;
> }
>=20
> +static inline int insert_ok(blk_t *array, int cnt, blk_t new)
> +{
> +   return (cnt =3D=3D 0 || array[cnt - 1] !=3D new);
> +}
> +
> +/*
> + * Merge list from src to dest
> + */
> +static errcode_t merge_u32_list(ext2_u32_list src, ext2_u32_list dest)
> +{
> +   errcode_t    retval;
> +   int      src_count =3D src->num;
> +   int      dest_count =3D dest->num;
> +   int      size =3D src_count + dest_count;
> +   int      size_entry =3D sizeof(blk_t);
> +   blk_t       *array;
> +   blk_t       *src_array =3D src->list;
> +   blk_t       *dest_array =3D dest->list;
> +   int      src_index =3D 0;
> +   int      dest_index =3D 0;
> +   int      uniq_cnt =3D 0;
> +
> +   if (src->num =3D=3D 0)
> +       return 0;
> +
> +   retval =3D ext2fs_get_array(size, size_entry, &array);
> +   if (retval)
> +       return retval;
> +
> +   /*
> +    * It is possible that src list and dest list could be
> +    * duplicated when merging badblocks.
> +    */
> +   while (src_index < src_count || dest_index < dest_count) {
> +       if (src_index >=3D src_count) {
> +           for (; dest_index < dest_count; dest_index++)
> +               if (insert_ok(array, uniq_cnt, dest_array[dest_index]))
> +                   array[uniq_cnt++] =3D dest_array[dest_index];
> +           break;
> +       }
> +       if (dest_index >=3D dest_count) {
> +           for (; src_index < src_count; src_index++)
> +               if (insert_ok(array, uniq_cnt, src_array[src_index]))
> +                   array[uniq_cnt++] =3D src_array[src_index];
> +           break;
> +       }
> +       if (src_array[src_index] < dest_array[dest_index]) {
> +           if (insert_ok(array, uniq_cnt, src_array[src_index]))
> +               array[uniq_cnt++] =3D src_array[src_index];
> +           src_index++;
> +       } else if (src_array[src_index] > dest_array[dest_index]) {
> +           if (insert_ok(array, uniq_cnt, dest_array[dest_index]))
> +               array[uniq_cnt++] =3D dest_array[dest_index];
> +           dest_index++;
> +       } else {
> +           if (insert_ok(array, uniq_cnt, dest_array[dest_index]))
> +               array[uniq_cnt++] =3D dest_array[dest_index];
> +           src_index++;
> +           dest_index++;
> +       }
> +   }
> +
> +   ext2fs_free_mem(&dest->list);
> +   dest->list =3D array;
> +   dest->num =3D uniq_cnt;
> +   dest->size =3D size;
> +   return 0;
> +}
>=20
> /*
>  * This procedure creates an empty u32 list.
> @@ -91,6 +159,13 @@ errcode_t ext2fs_badblocks_copy(ext2_badblocks_list sr=
c,
>                   (ext2_u32_list *) dest);
> }
>=20
> +errcode_t ext2fs_badblocks_merge(ext2_badblocks_list src,
> +                ext2_badblocks_list dest)
> +{
> +   return merge_u32_list((ext2_u32_list) src,
> +                 (ext2_u32_list) dest);
> +}
> +
> /*
>  * This procedure frees a badblocks list.
>  *
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 9cc994b1..18dddc2c 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -845,6 +845,8 @@ extern int ext2fs_badblocks_list_iterate(ext2_badblock=
s_iterate iter,
> extern void ext2fs_badblocks_list_iterate_end(ext2_badblocks_iterate iter)=
;
> extern errcode_t ext2fs_badblocks_copy(ext2_badblocks_list src,
>                       ext2_badblocks_list *dest);
> +extern errcode_t ext2fs_badblocks_merge(ext2_badblocks_list src,
> +                   ext2_badblocks_list dest);
> extern int ext2fs_badblocks_equal(ext2_badblocks_list bb1,
>                  ext2_badblocks_list bb2);
> extern int ext2fs_u32_list_count(ext2_u32_list bb);
> --=20
> 2.37.3
>=20
