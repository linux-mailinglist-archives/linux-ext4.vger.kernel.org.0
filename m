Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A16B6AE4A4
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 16:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjCGP1y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 10:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjCGP1b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 10:27:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7322E6189
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 07:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678202665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49sjefw2FKulo5Vz5tQGPSxZQZKzbcJ05HQTQwuGmNA=;
        b=K3a2U+JcTFquURmnnk7zht+qzO/+5yOo4CBmQgVcGdgmNMUJvBRlzmiI+upqHs27BCV/Zj
        aaWeMJBuTiMvt4v3ru6Iq1jXf20qhs7vJF4DTDx3GiOLwwE+zHZDsRs1ri5/Qv+pbKxHj/
        TdmVv3J/AL0OVSdU7355PBWWpY/04a8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-2uhivQfUP76BRMlNsweQWg-1; Tue, 07 Mar 2023 10:24:14 -0500
X-MC-Unique: 2uhivQfUP76BRMlNsweQWg-1
Received: by mail-pf1-f197.google.com with SMTP id h1-20020a62de01000000b005d943b97706so7303941pfg.0
        for <linux-ext4@vger.kernel.org>; Tue, 07 Mar 2023 07:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49sjefw2FKulo5Vz5tQGPSxZQZKzbcJ05HQTQwuGmNA=;
        b=FKHcTzevlKu3KGdpTQ9HHZUHuq+Cf6JnWxSqMqS9WlQMlsIFWJ/hYMVDzhP+XGCAt0
         ApaQ1E/pbNCMZzyfg8G11oBpoedwEX92gGp0c67iFCOb8Fqb1cweBzZZKTN57xnBeYaP
         soIfmEZz2Fj4zFMS3qOWesNybqdwV8BZ2EizigvIYyJ9DvQj0NvMMpwptBUE1dsUBaxJ
         GDmEvmTM2vnt/r21VIPJbiEkGmAwbD6hTx85UoYvgK2jOk3/jKLbHiLolI/B/VorP+Aq
         Uu3P5kPJaHzdq1TqO+//hDYEDUkrMqwDwcUfRud+//2bWCsZ7pow4JAd4ETLA6WkNYnU
         7kIw==
X-Gm-Message-State: AO0yUKXDU7aEHfm2YAhUlRJCaKdxAbsWL6Hpp0y0kzq+vTzn7lDjKlWa
        646gvQXQ98zHekiBcMB4p0xYESoXnSalWX8RAC6T+atarxgcy2T2wvVkjhkir3k1F6JiRPiR4Pi
        RPoYmGBb9cb9Mu70RMRfD5K3o1LNJPd3TaPjGng==
X-Received: by 2002:a17:902:f812:b0:19a:f153:b73e with SMTP id ix18-20020a170902f81200b0019af153b73emr5668628plb.4.1678202642956;
        Tue, 07 Mar 2023 07:24:02 -0800 (PST)
X-Google-Smtp-Source: AK7set9SWy5O05m3x1Ey9TSLMznr1jfUxFnvxAX39KEBXqqmaUx44UhyFFrhNGEtwClSqvzd8jjgUVc0X6h/fPAWheE=
X-Received: by 2002:a17:902:f812:b0:19a:f153:b73e with SMTP id
 ix18-20020a170902f81200b0019af153b73emr5668618plb.4.1678202642668; Tue, 07
 Mar 2023 07:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20230307143410.28031-1-hch@lst.de>
In-Reply-To: <20230307143410.28031-1-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 7 Mar 2023 16:23:50 +0100
Message-ID: <CAHc6FU4G5S+5S+1OdatY3apQvmDcvzOQSPPPQdQZTwMNjSq5tw@mail.gmail.com>
Subject: Re: [Cluster-devel] return an ERR_PTR from __filemap_get_folio v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 7, 2023 at 4:07=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
> __filemap_get_folio and its wrappers can return NULL for three different
> conditions, which in some cases requires the caller to reverse engineer
> the decision making.  This is fixed by returning an ERR_PTR instead of
> NULL and thus transporting the reason for the failure.  But to make
> that work we first need to ensure that no xa_value special case is
> returned and thus return the FGP_ENTRY flag.  It turns out that flag
> is barely used and can usually be deal with in a better way.

Thanks for working on this cleanup; looking good at a first glance.

Andreas

