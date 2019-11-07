Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2725BF25A6
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2019 03:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfKGCyw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 21:54:52 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25387 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727665AbfKGCyw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 21:54:52 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573095284; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Sp4LJjwZjmKp/YDrJuCR5/O0ofa+4d1J8y/aWeqZOmv4fXA+P0opWZKGYYqrd6++epAMRzR2bf4RdXOv+6nj38ncqHCMaX14WyJtaRRZxkcGyP0ab8QY+3UVkd5xY0GJP7xBm7GS7mK+ca2Kct54ZZmnRR3hJ7M9auCxT7qb4Ug=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1573095284; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=kOfMmBVsaB0uG9/GOqond2RwARJXXM3djFxFU6ABHEE=; 
        b=OhI96ZCefD2WzKQds7MH1EF0YxyK1uCveTXtyCJUDm69X6193FRXY7OGAXlL7iT73b9WIg10evWWSt9df2vC6kcvSuQr7NF6rjQhG4jdKYTSutqnbJ3oI2H89zCYi90Fg7nEtEiu3MyFe2UoHSzxz1XSs2NsnrC3NgKVAX/9Nf4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573095284;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=755; bh=kOfMmBVsaB0uG9/GOqond2RwARJXXM3djFxFU6ABHEE=;
        b=LQqXRtW3CdbamwPJO3EsDBcu8BsNvPo6Dajt4GNt71WL9rh1Oj9g9JmkM/cT+RoI
        Gz51gfm1gnHcK78ymhGFBHvruUQpHER9iPecLLiYNHfwXlbIcRyLdDRNBGGReQ0BI2i
        I1q4t4tP6ucMrOROmymoRlsbqwntxLPQZYz8V3lM=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1573095283537794.0021523349895; Thu, 7 Nov 2019 10:54:43 +0800 (CST)
Date:   Thu, 07 Nov 2019 10:54:43 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "jack" <jack@suse.com>, "linux-ext4" <linux-ext4@vger.kernel.org>
Message-ID: <16e43c91b4e.12c0f5d17918.413402503051848643@mykernel.net>
In-Reply-To: <20191106154236.GB12685@quack2.suse.cz>
References: <20191104114036.9893-1-cgxu519@mykernel.net>
 <20191104114036.9893-2-cgxu519@mykernel.net> <20191106154236.GB12685@quack2.suse.cz>
Subject: Re: [PATCH 2/5] ext2: code cleanup by calling
 ext2_group_last_block_no()
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2019-11-06 23:42:36 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Mon 04-11-19 19:40:33, Chengguang Xu wrote:
 > > Call common helper ext2_group_last_block_no() to
 > > calculate group last block number.
 > >=20
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 >=20
 > Thanks for the patch! I've applied it (as well as 1/5) and added attache=
d
 > simplification on top.
 >=20

In ext2_try_to_allocate()

+=09=09if (my_rsv->_rsv_end < group_last_block)
+=09=09=09end =3D my_rsv->_rsv_end - group_first_block + 1;
+=09=09if (grp_goal < start || grp_goal > end)

Based on original code, shouldn't it be  if (grp_goal < start || grp_goal >=
=3Dend) ?

Thanks,
Chengguang

