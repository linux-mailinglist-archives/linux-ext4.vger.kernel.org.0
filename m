Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50EF2B0C
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2019 10:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfKGJoy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Nov 2019 04:44:54 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25339 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726866AbfKGJoy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Nov 2019 04:44:54 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573119865; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=SU3RDOaUnLCn1QGmgxhYMtOZHui9oOTqEGZFwcWr6lEwHhNArWGDfzimwthxZJnHEUADwLJONor8kC76CRAmtsj0laxIJtremQPniog+B4NtFEtccLF0X6mWLSl3OV6ortq25wXx3fdORq0t2LsHkVjzWj9uTdM3nt2wxo2MnUA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1573119865; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=pqYHCzjtbdk0Vsetr9tkPwToVHLSqWDh9kTs/tHPJR8=; 
        b=dwK5dQV8ZN1jh0dpPFUfuR0qegGRMo+8cUyq61Jzt5/9QGDJHwnBsxxnIpqr7PYSMpVToq/F1SGf54VQWO7MnRj+LuTuQi47qyV/oCvey3FAnJw0GEp2xQ+oCcNeqjz/dKPkHgMNBRx8p7KqXE9vXrDWnuzpXvZOwObwbIwisQM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573119865;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=1609; bh=pqYHCzjtbdk0Vsetr9tkPwToVHLSqWDh9kTs/tHPJR8=;
        b=Q0euPC4jEtWv/UBjsEG7GStGlvYZP8+CkUdSDCGd5dqwZYkALpeRVB/hJ0x25DlZ
        a4sfCcDdZWRKeer4iREAGZ8eZOQA2TeDCgflkH654V2Ak79xxCcm7V7gbOR0Z7o+t7z
        u4k+RJH4Ze6QvgQi6ll2EtO9dtqcA0IJslFQlPKs=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1573119863323397.8144115962217; Thu, 7 Nov 2019 17:44:23 +0800 (CST)
Date:   Thu, 07 Nov 2019 17:44:23 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "jack" <jack@suse.com>, "linux-ext4" <linux-ext4@vger.kernel.org>
Message-ID: <16e45402a18.c7fb3dc01505.2507377017571315195@mykernel.net>
In-Reply-To: <20191107092117.GA11400@quack2.suse.cz>
References: <20191104114036.9893-1-cgxu519@mykernel.net>
 <20191104114036.9893-2-cgxu519@mykernel.net>
 <20191106154236.GB12685@quack2.suse.cz>
 <16e43c91b4e.12c0f5d17918.413402503051848643@mykernel.net> <20191107092117.GA11400@quack2.suse.cz>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2019-11-07 17:21:17 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Thu 07-11-19 10:54:43, Chengguang Xu wrote:
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2019-11-06 23:42:36 Jan K=
ara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > >  > On Mon 04-11-19 19:40:33, Chengguang Xu wrote:
 > >  > > Call common helper ext2_group_last_block_no() to
 > >  > > calculate group last block number.
 > >  > >=20
 > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  >=20
 > >  > Thanks for the patch! I've applied it (as well as 1/5) and added at=
tached
 > >  > simplification on top.
 > >  >=20
 > >=20
 > > In ext2_try_to_allocate()
 > >=20
 > > +        if (my_rsv->_rsv_end < group_last_block)
 > > +            end =3D my_rsv->_rsv_end - group_first_block + 1;
 > > +        if (grp_goal < start || grp_goal > end)
 > >=20
 > > Based on original code, shouldn't it be  if (grp_goal < start || grp_g=
oal
 > > >=3Dend) ?
 >=20
 > Hum, that's a good point. The original code actually had an off-by-one b=
ug
 > because 'end' is really the last block that can be used so grp_goal =3D=
=3D end
 > still makes sense. And my cleanup fixed it. Now looking at the code in
 > ext2_try_to_allocate() we also have a similar bug in the loop allocating
 > blocks. There we can also go upto 'end' inclusive. Added a patch to fix
 > that. Thanks for pointing me to this!
 >=20

Doesn't it depend on what starting number for grp_block inside block group?
if it starts from 0, is the end number block still available for allocation=
?

Thanks,
Chengguang



