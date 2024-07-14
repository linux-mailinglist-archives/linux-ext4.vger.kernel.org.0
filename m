Return-Path: <linux-ext4+bounces-3250-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14482930BCD
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 23:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385051C20DAF
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 21:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C86513D63D;
	Sun, 14 Jul 2024 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxKWMlLF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95938DD7;
	Sun, 14 Jul 2024 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720993414; cv=none; b=iEJJQLQXv1zb0ZFHFFoTz3mWEt3V8eU9lRtNSQnmk96iFpD/M7XWKhw0LEx41/+qilAEyhc51PcfKS1a9ql3pt/kc4Bhtx2Eyb9dg5ijgzRBYn8WxN1tVOxXPhUEjZFG5wuPoEsBeQqOErMx5LZg/jT0N7Beu77QylGjMwRMAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720993414; c=relaxed/simple;
	bh=vTWgrLar9RwESUhW2DtbiZeEygyvaVhjub29QrcZkPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aETUtQbT94mmPsHeIJQe6M8ZuP6ujCg+5BZ33jbrGMIkKyxuRqdcowCyNJte/PYjOrACbu/Af8mfeMlfnSINR3iEQD+FWfR99ljOZ9yqVcyqJJmKnp6goid+pud3EXkOEUS3nApW5F4wDKk/+4wfCUkPFEky5DwXnpD3eh/Xdds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxKWMlLF; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79f18509e76so230017985a.1;
        Sun, 14 Jul 2024 14:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720993412; x=1721598212; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L06ctmeBFUkEJ55KaUD4TAo/b9mLXhzGenzcr6b66XU=;
        b=gxKWMlLFZoR4byxlLH5y4yVPCeCifSjXTwzfy1sdmyuHpRT8GMvGMpoUYR2IQDBeOB
         P+fb/A2BST9YjbUnHvpbsanGrJt6P57oXNS+mWbMEetxXL2ZQO3ZFwS8RZ4XGcf5bFXR
         KUwDD/pN4GLLvf1mJpiufBLxv9NroEDRvEtGWCgoND6L2X68L37SsQzHLRd90RWobGZw
         XVk9CsnF+rOqwHXAfdunlfzvSfoxDgYigAdNXKfbaRj5pwLQez6Cy7Oe/XbGOfTbSUAY
         dB+mDOnpTLSyn29OTYfek4yH0Utmxtxx/VICauFtIfJr4RFRXk3xoigGrRfHyXndLrBV
         ytWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720993412; x=1721598212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L06ctmeBFUkEJ55KaUD4TAo/b9mLXhzGenzcr6b66XU=;
        b=hxm9qVORrQmkNt3t4M7P9/nPucdO7Yb9ji2Cgp6f6OPPsewGHT/kWtK8bKVEGG16wz
         iE0ndQIUJ2jFWWzBnQnc36ElGM0kvs9xMvMm7VOpVU5eOHkkUXqlGQuRRhd+4Gu7AI8r
         Mj7OAZC30DBkSBpyWnsul0WQSmgNii+fmKcHvN1Z1NfbVncrb/6v3gx5NgXB0eRdKOEd
         0sNml6K6DCw18agMxnPamggBqZZNsvGykevcQXYFXjkUMe0/noXjxtDnP1etTR9tJAhr
         adhpvxhlgq63vL/4Al2uB0+9uV/BkQL+LF9pZ2+w7HZ4CjpmUHz+ZtzWRe+0lKdymWWh
         COuA==
X-Forwarded-Encrypted: i=1; AJvYcCWXT+EOufCiPfW1RW14VJ6gpR2A4+/GFK6xyKHY4sLV2CvkemyMZpJRwtdv78CN6p6asCPOzN1l0HY1I2wy+gIYi75rQxrejoJz0tYT6Aq7dmr2n/QoSs3QgAS5a/519i1iwb0OSywdcbjgoFXGUELJ+GQfYUurKCBoF9x7s+mwzA==
X-Gm-Message-State: AOJu0Yw5vRhDFdPJRn0EVH4+hhKj9kRoe3MILdj7iN0f2bm934Bi1u4T
	4H8HAGSP/X8RJTwXgQIyBRjcLQMd70tq+pqaHjhBHYrKJEhZKINy
X-Google-Smtp-Source: AGHT+IF5kKOH04cr8KwnxHC9oHBJ4XobZZ9D5cClbP5OIce/xvuv/l2MIqYrdAJ07RVbHxN15IY8uA==
X-Received: by 2002:a05:620a:2233:b0:79f:10a2:1361 with SMTP id af79cd13be357-79f19a1f5demr1704030685a.31.1720993412082;
        Sun, 14 Jul 2024 14:43:32 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160c65d47sm145753085a.88.2024.07.14.14.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 14:43:31 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id F28431200076;
	Sun, 14 Jul 2024 17:43:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 14 Jul 2024 17:43:30 -0400
X-ME-Sender: <xms:gUaUZpCw5S3Obhp8xHjC-stsmUqrVCRo_ySQ1MYtfN7JjC-I7R-bKA>
    <xme:gUaUZnipI9T0v6ZFvTXpnbavlICqWlbNmKCVVSiqw2HgakBdZHngSUDbOBtO_WmH5
    Ugu8DNEqqwlpQPK9g>
X-ME-Received: <xmr:gUaUZklQcZ_vHtWlSKUltvBiFHRpKSMGMf0QyXqw4vxm3_zvP-K69z3yi5yCFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedugddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejhfeikeekffejgeegueevffdtgeefudetleegjeelvdffteeihfelfeeh
    vdegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:gUaUZjwxkEdulBy6EtChVFsRhcCOHdl_aSO8563IMaEAjA7AjKREGw>
    <xmx:gUaUZuSiNKws2XLZliaWHhgKMIUOA19bbcWsslt54ruvQMx4R3JPag>
    <xmx:gUaUZmbP2P8KlRJBTzyQog91ginA8mO2Iq6t28pr1Epb92xB15lSiw>
    <xmx:gUaUZvSDS9KhmON8yr2aB939npqWh_bg3iavl2afF3UhS2dJPndJRQ>
    <xmx:gkaUZsAzVahvlk4cU8cd4bUAPNDFjpWPkpNjwJIhq9gVhOtnbkGo67y_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jul 2024 17:43:29 -0400 (EDT)
Date: Sun, 14 Jul 2024 14:41:54 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: ahmed Ehab <bottaawesome633@gmail.com>
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-ext4@vger.kernel.org, syzkaller@googlegroups.com,
	syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ext4: Forcing subclasses to have same name
 pointer as their parent class
Message-ID: <ZpRGItbffhICt8bh@boqun-archlinux>
References: <20240714051427.114044-1-bottaawesome633@gmail.com>
 <fff79c2a-d659-4faa-83e2-e36c2e2bda2b@redhat.com>
 <CA+6bSasRZ7HRURZcSPEsAyDtNDdx+7UGwuXRG+Dw0Gqo+vs9Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+6bSasRZ7HRURZcSPEsAyDtNDdx+7UGwuXRG+Dw0Gqo+vs9Ew@mail.gmail.com>

On Mon, Jul 15, 2024 at 12:39:45AM +0300, ahmed Ehab wrote:
> Ok, I will.
> I just put ext4 because the syzkaller bug was mentioned in the ext4
> subsystem.
> Thanks,
> Ahmed
> 

Please avoid top-posting. And 

> On Mon, Jul 15, 2024 at 12:22 AM Waiman Long <longman@redhat.com> wrote:
> 
> > On 7/14/24 01:14, botta633 wrote:
> > > From: Ahmed Ehab <bottaawesome633@gmail.com>
> > >
> > > Preventing lockdep_set_subclass from creating a new instance of the
> > > string literal. Hence, we will always have the same class->name among
> > > parent and subclasses. This prevents kernel panics when looking up a
> > > lock class while comparing class locks and class names.
> > >
> > > Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
> > > Fixes: fd5e3f5fe27

please add the title of the commit here as well, e.g.

Fixes: <sha1> ("<title>")

see

	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f7ce5eb2cb7993e4417642ac28713a063123461f	

for example.

Regards,
Boqun

> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
> > > ---
> > >   include/linux/lockdep.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > > index 08b0d1d9d78b..df8fa5929de7 100644
> > > --- a/include/linux/lockdep.h
> > > +++ b/include/linux/lockdep.h
> > > @@ -173,7 +173,7 @@ static inline void lockdep_init_map(struct
> > lockdep_map *lock, const char *name,
> > >                             (lock)->dep_map.lock_type)
> > >
> > >   #define lockdep_set_subclass(lock, sub)
> >      \
> > > -     lockdep_init_map_type(&(lock)->dep_map, #lock,
> > (lock)->dep_map.key, sub,\
> > > +     lockdep_init_map_type(&(lock)->dep_map, (lock)->dep_map.name,
> > (lock)->dep_map.key, sub,\
> > >                             (lock)->dep_map.wait_type_inner,          \
> > >                             (lock)->dep_map.wait_type_outer,          \
> > >                             (lock)->dep_map.lock_type)
> >
> > ext4 is a filesystem. It has nothing to do with locking/lockdep. Could
> > you resend the patches with the proper prefix of "lockdep:" or
> > "locking/lockdep:"?
> >
> > Thanks,
> > Longman
> >
> >

