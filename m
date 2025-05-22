Return-Path: <linux-ext4+bounces-8168-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA44AC018C
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 02:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677E2A22335
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E23597E;
	Thu, 22 May 2025 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="X9R2BNBP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B057A50
	for <linux-ext4@vger.kernel.org>; Thu, 22 May 2025 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747875074; cv=none; b=JuIECd7iBpPJ549qjig2H+U1z1UW8yjxLAypJBRfnQpriEL+87tb0tFjKYj2W2GZHuPErBpEl27Aw/v0pG32UgWnzNfmcJz6mZztOPDDdQKYwfFekuqovxqEcjee73tAAujdiFjF9MKvhW+tvMSLe1oyWHrBUtrcYXZUtHiEDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747875074; c=relaxed/simple;
	bh=Rj6K4ROrMnzGhkR+BEROkzwz0ATU+50+nOs4dIgSHIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2Dye+2ieDL859K97UehEYbhRY16ZMlbUW7/9s9HGWrY4/gNGq75qrpLo2OwtEV4df//ve1FrhWkPawtIhQcgjuRBziNg3nm4AHPxf3lymsG8Jhkf/WJ3MPntNe4/hcRCSxA15rGZnDrUtAaWryWT1RpHjo90aymR7KGVuHell0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=X9R2BNBP; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so6964439b3a.0
        for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747875069; x=1748479869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9s0Ocr/rcF17F3DaJ0nz5ajfwkc6fT/gYdoWUk+45Q=;
        b=X9R2BNBPPXMoENAmPna2fvi7CwxquWjYwfQ6Qxv7SZ/mLMDmMj2PXb5UShXGOkXzjd
         0SyjIJw/tiD1qdTqYW3N51r7kh9eo82vMcJcqgByjF5RLPE3W1iu3EQGti5eLME7hl1d
         cfIfNbE56MtekEdz0RBpZqrP4N39Zw2cF8FGmIvV2k0+e9H8GlDrSOIG6gYAM+H8wYCG
         oXliTn6pGWsaDupoph0CveQH8eVF52RKc+gw2CAXm59K/eVIpCtVVbBzfK1G6UvjHiKl
         daYanrpnQgV680IqpCPmNhgDeqHusYKwnJwY/zGTq3ojf5EySOfCGFWR4v65bCpNWjCc
         ngsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747875069; x=1748479869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9s0Ocr/rcF17F3DaJ0nz5ajfwkc6fT/gYdoWUk+45Q=;
        b=vMI6bBPsJ4eSbgNbyD+G/m5kLbbLvcRTWMJHzuYp6dv6Pe8I7u8pvigD4vtBFshyfv
         8zGgIscc1W5erlu4I+IfLFAW4nh7floyI8DMjvCfSYSc3wk1G6I/+RtjCQHOj8YR0kU3
         Ug4oIp89DdsnZzQLeBNVTAZyNq95uSf3/8RfBOZeoeLfC8yTi7vwCMJCpgU5u6QyuQSu
         Z1c4czGDouUj6vsvgUGXL0LA3o8QqpJD/DhVeoZ2z6xuhnVZ9N3Dm0apJbNbalKkRS6+
         c9DXYmfPR7t2hwgS72yrgHlJ8RLEyFZQZr7oyDv7/gbK0134vDQp6UhLlb12rQy4yBzH
         g6Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWmrUbc+s8c+TWOEpOnPe2BLYyid8X6bB/efZl9HDIBrh03BvEKhRZakmDzBaMhGakO8R+DabA1AwHw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgcwxh9UWJyl5fWjZQe9uT1GaYMaJgokTgHs7er6e9RD0HCEnN
	Y6xP/jLiqELXh/Z49zMSz+68uQrgbLDt4U11cRQErWz9uS+KeZeIcqnKdXEBcjYD45E=
X-Gm-Gg: ASbGnct7RQhJ+MvXN46bKl0ZekqUyrBpB0b6Bt4faTiL0IXqRuM1Q7rId7O/UKNsRsa
	DZIUzIvj/tFofHhTQPG7iHjQJZKujYZ5XpDRy4C0U5T8J0CnsaJHB8o4zX2lS0mmmrlVaisHs7O
	/BMbdAoN0/WQr1rBM2dTFyMo8CM1SaHUwNMpPD0rBLmjNanjeax6vkb6f5EIWqZcu/YHCcPSb37
	QTkM+xPIO9DiknFZ0/5oCX0YkDVOH5osi3isB14CAd0e0/kPXJuPTv9rIRB5UcIcOBGv3ABtzfJ
	ROoptUNikRrBI6gIY40hCnH6qsBkCOjGU9T6Hoa1dD9M+SjRo7IP7aFWl5j/sAh4ufTQcQi8dEw
	zH4KA/w8VltVA+zxjCFUxqW9AoBk=
X-Google-Smtp-Source: AGHT+IGP/CEXCaGuQkCNk+FfpfP4/PxKrZ35x7SLbTy5h2U+tyAempmwH+hmFi9rXwNEsKJVKpY7Pw==
X-Received: by 2002:a17:90a:d2ce:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-30e7dc4ecb4mr32283593a91.5.1747875068659;
        Wed, 21 May 2025 17:51:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365f7a32sm4265696a91.49.2025.05.21.17.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 17:51:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHu9H-00000006WPt-2p6p;
	Thu, 22 May 2025 10:51:03 +1000
Date: Thu, 22 May 2025 10:51:03 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v2 1/2] new: Add a new parameter (name/emailid) in the
 "new" script
Message-ID: <aC509xXxgZJKKZVE@dread.disaster.area>
References: <cover.1747306604.git.nirjhar.roy.lists@gmail.com>
 <2df3e3af8eb607025707e120c1b824879e254a01.1747306604.git.nirjhar.roy.lists@gmail.com>
 <aC0Q2HIesHMXqVLG@dread.disaster.area>
 <12e307e0-2a28-4a42-a8b3-d2186c871be7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e307e0-2a28-4a42-a8b3-d2186c871be7@gmail.com>

On Wed, May 21, 2025 at 10:52:22AM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 5/21/25 05:01, Dave Chinner wrote:
> > On Thu, May 15, 2025 at 11:00:16AM +0000, Nirjhar Roy (IBM) wrote:
> > > This patch another optional interactive prompt to enter the
> > > author name and email id for each new test file that is
> > > created using the "new" file.
> > > 
> > > The sample output looks like something like the following:
> > > 
> > > ./new selftest
> > > Next test id is 007
> > > Append a name to the ID? Test name will be 007-$name. y,[n]:
> > > Creating test file '007'
> > > Add to group(s) [auto] (separate by space, ? for list): selftest quick
> > > Enter <author_name> <email-id>: Nirjhar Roy <nirjhar.roy.lists@gmail.com>
> > > Creating skeletal script for you to edit ...
> > >   done.
> > > 
> > > ...
> > > ...
> > > 
> > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > > ---
> > >   new | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/new b/new
> > > index 6b50ffed..636648e2 100755
> > > --- a/new
> > > +++ b/new
> > > @@ -136,6 +136,9 @@ else
> > >   	check_groups "${new_groups[@]}" || exit 1
> > >   fi
> > > +read -p "Enter <author_name>: " -r
> > > +author_name="${REPLY:=YOUR NAME HERE}"
> > > +
> > >   echo -n "Creating skeletal script for you to edit ..."
> > >   year=`date +%Y`
> > > @@ -143,7 +146,7 @@ year=`date +%Y`
> > >   cat <<End-of-File >$tdir/$id
> > >   #! /bin/bash
> > >   # SPDX-License-Identifier: GPL-2.0
> > > -# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
> > > +# Copyright (c) $year $author_name.  All Rights Reserved.
> > In many cases, this is incorrect.
> > 
> > For people who are corporate employees, copyright for the code they
> > write is typically owned by their employer, not the employee who
> > wrote the code. i.e. this field generally contains something like
> > "Red Hat, Inc", "Oracle, Inc", "IBM Corporation", etc in these
> > cases, not the employee's name.
> 
> Yes. The existing placeholder is already "YOUR NAME HERE" (which I have kept
> unchanged). The author can always use the company's name from read -p prompt
> or simply chose to fill it up later, right? Or are you saying that the
> existing placeholder "YOUR NAME HERE" is incorrect?

I'm noting that your prompt - <author_name> - is incorrect
for this "YOUR NAME HERE" field. That field is supposed to contain
the -copyright owner-, not the author of the patch. Sometimes they
are the same, but in many cases they are not.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

