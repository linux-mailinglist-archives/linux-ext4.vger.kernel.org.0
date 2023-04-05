Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E03B6D7743
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 10:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbjDEIsQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 04:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbjDEIsM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 04:48:12 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A8A3599;
        Wed,  5 Apr 2023 01:48:11 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id v5so15878890ilj.4;
        Wed, 05 Apr 2023 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680684491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+I6RLfy7p3pfnrp1t4tfB17I5n8zpBk+7c0bn0ShMwk=;
        b=BG3AEdrJJ0ZcQ2QpGmViN9LyS+MPb/fqMGFAr5Grwyj3ovcJOmc1pTHjPyIL1XD/AX
         G66whUC3DnyDBqcK2Y5sH8DubURH4ns2a1SXG6vHaK8G8mrsJ2yPvWQDnnXjSPB6MHPk
         dS85xVYbu7J3mGbGFcBRUOldjIXBmnOJQ7sSy7unpS51TfqKTyNpDg5hciebMH7XKE6F
         bGmEKTAOu78E+yhHOFbpua5J2R/mTscFRNH08vSnMh+pqnB9fut1gK36jF8cqzXE8MdK
         u7okQX6g2pz7IK3zadkrbkPAMGL89G1tBfl/HtjhiGJlJIC42giDgHEvDrKOa8oXPEGM
         m/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680684491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+I6RLfy7p3pfnrp1t4tfB17I5n8zpBk+7c0bn0ShMwk=;
        b=nrlvPLqXIDwFGxpZE0TwA4UY6/xsFrS74uRx/EJgT8NXL2SRVnsQ3MipcJ5fyWjZ5l
         4K5RhbOt6adFkUXAD54WWUudHfAoNki8sgcIMu9XMHNtHxDglkNeqfmwBVReXafMdYAL
         syPn9kTdv3mRfL2RwrOe8gx3JIl01DKwomz7eIApKOI7odiskbvXX7UPkBtnCFUispvB
         gm2C9kyRHGXY/1cImEX8qcJjVNSF0L5IhnVX6CiU/0cER50jIqiGmiv/NruElG05apLU
         adX1PfuMeqYxfKUGUqkHRMKQtPknYXdpJhXOucNDBGbpGDhSIqXIVhWvjb68iyVGjenB
         wIyg==
X-Gm-Message-State: AAQBX9fGnipoNNmfoVRE1Wx8InSLV+XPIs/Goj6p4Gl3pJm4acfcqB1y
        YB/JtgiAf3TyFfXdBnIQwSxy8/om58hF9iFu3CM=
X-Google-Smtp-Source: AKy350bt+tihLu4R/cuRxtZMh9NKFLSUtLTfqU8EqI8rR6ILEh5Rmsp1q3KCTonEB2gR18n1tuSY7+NU35k6ABFa+Lk=
X-Received: by 2002:a05:6e02:96c:b0:326:4af5:28b5 with SMTP id
 q12-20020a056e02096c00b003264af528b5mr1448626ilt.3.1680684490954; Wed, 05 Apr
 2023 01:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230403135304.19858-1-wuchi.zero@gmail.com> <ZC0J6I1pYNZBB30y@infradead.org>
In-Reply-To: <ZC0J6I1pYNZBB30y@infradead.org>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Wed, 5 Apr 2023 16:47:59 +0800
Message-ID: <CA+tQmHA_3_Oc-0AQ0a29DTwU4mkEqhOiAE6gXa4Ly4gZGpn5Vw@mail.gmail.com>
Subject: Re: [PATCH] ext4: simplify 32bit calculation of lblk
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=B8=89 13:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Apr 03, 2023 at 09:53:04PM +0800, wuchi wrote:
> > -                     if (block > ext_block)
> > -                             return ext_pblk + (block - ext_block);
> > -                     else
> > -                             return ext_pblk - (ext_block - block);
> > +                     return ext_pblk + ((signed long long)block - (sig=
ned long long)ext_block);
>
> And what exactly is the value add here, except for turning an easy
> to parse statement into a complex expression using casts?
>
Yes=EF=BC=8Cit will be more complex. the original intention is to reduce th=
e
conditional branch.

=3D=3D=3D=3D=3D=3D=3D
