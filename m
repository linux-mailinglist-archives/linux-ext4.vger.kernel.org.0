Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3251F62F678
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 14:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiKRNmP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 08:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242226AbiKRNmH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 08:42:07 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2776175
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:42:06 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13c2cfd1126so5932480fac.10
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvLcHjOZ0Z9OY9sq4MbAn3vaDCHpHH7Daxh0EhphA3w=;
        b=nSUbDFW5czDu4UHRWS+aFUOcilc6WJpWSOR+I6anDHoDEfCdm2cc8JCXVqNFAPXe9A
         IQRSqf729VIeyv0xjGGCh1hXESQ1nzCD/m04iBQACRE4/EC6RdNOryBk2PnN68staAXH
         PM62nDs/L36Ain8dw3ztyF2I6DB+LBDoztpqcNf+2IayIxVrgCS+BFpoLi4DGTdcU3ff
         UQjz+tkwkX2Z88u/EBl/VL2TWCm7dQD4LgAuAdLbq2AZKDs+6M///+QHum9slcmJdIDY
         QEYojEpDmbBOZNLf1HinZMLt2QDVCOEMLXAIuKDzJeWE2WYZgoQAj7KKxEXqr4Qj5jrt
         b28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvLcHjOZ0Z9OY9sq4MbAn3vaDCHpHH7Daxh0EhphA3w=;
        b=24OZqfruBcAvfWaZ3mF9A3K1DKMeUuqfA4K5omqHnMa045gF9+ohOOf91f5h3N199p
         XJJ33EVO92HniTnNHqvKowr67AK1Ks7Aw9A1kpZhge0NkuT5Oy7NhACPrNvBZre6iYkl
         Y7K+YCFGrKhD6vAmxS+dkFpR++ZkMF4lmSBlSFnAGFu/gGKaBAik32EOIbfrR07MfnZt
         6UL8tmPoCNf+9KycQXSJHBtB6rU9MpgMZx8mW5iHWFZxWC1L5d5C9G0m/iuPXnYU2QId
         H1MqfZmT4CDZkTjKEeFAIOXACte0LAUSqfOeqvSeEFtQ10SOp4uWxc+dkfWvPMCIWEzi
         SCAA==
X-Gm-Message-State: ANoB5pnp3hg/8de7bWKZ+VTYOipMAqCC5IHYKDvJCfrqWcPkojemsLLg
        m+AVtpsOpeyT+b1+WyJsv4u2zOzmmtlyp/Pq
X-Google-Smtp-Source: AA0mqf5+Uji90HxM8lm4Mrt2QkLw0+WMDFsuqp4V4tBenYJ0sqghe5HEE6RVeWeHu6vHPayYvai4zQ==
X-Received: by 2002:a05:6870:b48a:b0:136:d212:2e82 with SMTP id y10-20020a056870b48a00b00136d2122e82mr3921777oap.72.1668778925747;
        Fri, 18 Nov 2022 05:42:05 -0800 (PST)
Received: from smtpclient.apple ([205.169.26.81])
        by smtp.gmail.com with ESMTPSA id bg34-20020a05680817a200b003549db40f38sm1413429oib.46.2022.11.18.05.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:42:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFCv1 11/72] libext2fs: merge quota context after threads finish
Date:   Fri, 18 Nov 2022 07:42:04 -0600
Message-Id: <7B432201-71B8-4569-BAD3-805477B4D226@dilger.ca>
References: <a318a46cc1439f32c0fb795d8aa0a435bcfb7e04.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
In-Reply-To: <a318a46cc1439f32c0fb795d8aa0a435bcfb7e04.1667822611.git.ritesh.list@gmail.com>
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

On Nov 7, 2022, at 06:23, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote=
:
>=20
> =EF=BB=BFFrom: Wang Shilong <wshilong@ddn.com>
>=20
> Every threads calculate its own quota accounting,
> merge them after threads finish.
>=20
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> [Note: splitted the patch to seperate libext2fs changes from e2fsck]
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/support/mkquota.c | 39 +++++++++++++++++++++++++++++++++++++++
> lib/support/quotaio.h |  3 +++
> 2 files changed, 42 insertions(+)
>=20
> diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
> index 9339c994..ce1ab4cd 100644
> --- a/lib/support/mkquota.c
> +++ b/lib/support/mkquota.c
> @@ -618,6 +618,45 @@ out:
>    return err;
> }
>=20
> +static errcode_t merge_usage(dict_t *dest, dict_t *src)
> +{
> +    dnode_t *n;
> +    struct dquot *src_dq, *dest_dq;
> +
> +    for (n =3D dict_first(src); n; n =3D dict_next(src, n)) {
> +        src_dq =3D dnode_get(n);
> +        if (!src_dq)
> +            continue;
> +        dest_dq =3D get_dq(dest, src_dq->dq_id);
> +        if (dest_dq =3D=3D NULL)
> +            return -ENOMEM;
> +        dest_dq->dq_dqb.dqb_curspace +=3D src_dq->dq_dqb.dqb_curspace;
> +        dest_dq->dq_dqb.dqb_curinodes +=3D src_dq->dq_dqb.dqb_curinodes;
> +    }
> +
> +    return 0;
> +}
> +
> +
> +errcode_t quota_merge_and_update_usage(quota_ctx_t dest_qctx,
> +                    quota_ctx_t src_qctx)
> +{
> +    dict_t *dict;
> +    enum quota_type    qtype;
> +    errcode_t retval =3D 0;
> +
> +    for (qtype =3D 0; qtype < MAXQUOTAS; qtype++) {
> +        dict =3D src_qctx->quota_dict[qtype];
> +        if (!dict)
> +            continue;
> +        retval =3D merge_usage(dest_qctx->quota_dict[qtype], dict);
> +        if (retval)
> +            break;
> +    }
> +
> +    return retval;
> +}
> +
> /*
>  * Compares the measured quota in qctx->quota_dict with that in the quota i=
node
>  * on disk and updates the limits in qctx->quota_dict. 'usage_inconsistent=
' is
> diff --git a/lib/support/quotaio.h b/lib/support/quotaio.h
> index 84fac35d..240a0762 100644
> --- a/lib/support/quotaio.h
> +++ b/lib/support/quotaio.h
> @@ -40,6 +40,7 @@
> #include "ext2fs/ext2_fs.h"
> #include "ext2fs/ext2fs.h"
> #include "dqblk_v2.h"
> +#include "support/dict.h"
>=20
> typedef int64_t qsize_t;    /* Type in which we store size limitations */
>=20
> @@ -236,6 +237,8 @@ int quota_file_exists(ext2_filsys fs, enum quota_type q=
type);
> void quota_set_sb_inum(ext2_filsys fs, ext2_ino_t ino, enum quota_type qty=
pe);
> errcode_t quota_compare_and_update(quota_ctx_t qctx, enum quota_type qtype=
,
>                   int *usage_inconsistent);
> +errcode_t quota_merge_and_update_usage(quota_ctx_t dest_qctx,
> +                    quota_ctx_t src_qctx);
> int parse_quota_opts(const char *opts, int (*func)(char *));
>=20
> /* parse_qtype.c */
> --=20
> 2.37.3
>=20
