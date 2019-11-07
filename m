Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37AA0F25A8
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2019 03:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732951AbfKGC6Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 21:58:16 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25363 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727665AbfKGC6Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 21:58:16 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573095484; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=PSeZBo52JhXncvyKYXlpwPfdwfzrm9P/5h6vUUmmV9Sz2Q4Ds0vEMxFIyiKAUPZmNZEvsBF0ypFn11GJtLfPBTHF6pgRNTdlRzo0yvhWQElVOQ/bw2kSOKl3VKjrlS9GZtoLdl1bcM/ty8d9wgHNxn1oKq/sIhXPQv2wQpwJE3I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1573095484; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=N+1w3mItBQ0eGakspfilaXJr2gCo3j9+9ebN6nqI+Ek=; 
        b=AHMeRedcXCn7DA3QTcqqcYq2Y81iILGW9/Siqx0AMUDGculS8mhBKmtVVkhoFcCqmirQnxqgJZPG/WwQ7jx8XuqGsA2y3HxXrq8xig1jalmvni+devR9ge2BpUyXr50ctmlZthRb3/sULUsGBeTxHyMQn/66Tt0vgc5wL9FANQg=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573095484;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=536; bh=N+1w3mItBQ0eGakspfilaXJr2gCo3j9+9ebN6nqI+Ek=;
        b=dWmd4T89qWdP4Uqghuhlh0rg9nWy9NPbyyenfaEiM9ftbMIDAxQj0yE0m2FmeaFJ
        +h2z5xygLHfejnl0n2vdRDwD6UmXJGmEynOwdFxadvWPsypFm0h7Jc1iI8hFjdCjHB0
        jip7LBMFJjQS2eDwwxBQnSpQX6TMXee5vFcsk0gc=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 157309548317966.63134305884375; Thu, 7 Nov 2019 10:58:03 +0800 (CST)
Date:   Thu, 07 Nov 2019 10:58:03 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "jack" <jack@suse.com>, "linux-ext4" <linux-ext4@vger.kernel.org>
Message-ID: <16e43cc2728.de6ac2bc928.3996069392231034746@mykernel.net>
In-Reply-To: <20191106155900.GC12685@quack2.suse.cz>
References: <20191104114036.9893-1-cgxu519@mykernel.net>
 <20191104114036.9893-4-cgxu519@mykernel.net> <20191106155900.GC12685@quack2.suse.cz>
Subject: Re: [PATCH 4/5] ext2: code cleanup for ext2_try_to_allocate()
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2019-11-06 23:59:00 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Mon 04-11-19 19:40:35, Chengguang Xu wrote:
 > > Code cleanup by removing duplicated code.
 > >=20
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 >=20
 > Thanks for the patch! I've merged it with a small update to switch the
 > while() loop into a for() loop which is somewhat more natural in that
 > situation. Resulting patch attached.
 >=20

Looks fine to me.=20


Thanks,
Chengguang

