Return-Path: <linux-ext4+bounces-7301-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAC7A8AC15
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Apr 2025 01:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649EE16F2A1
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Apr 2025 23:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A05D2D8DC2;
	Tue, 15 Apr 2025 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Z5oKluK1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5802D8DA3
	for <linux-ext4@vger.kernel.org>; Tue, 15 Apr 2025 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759727; cv=none; b=Blmy+04fAfZ9MDEjEqo3/+Z1Oh3SQxgvM4B1DFqtgHfxwUg6GjkIHXaISX6Z51WDVkolbI4bf1mEvfq30Dme02QFeWfWoYsJBH9efJIhtRuXWVYostNDlfqh66xvTN0spFArk5KfSkTux8XKtd/rNtt1WtyCLZlPwVUyFZyCBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759727; c=relaxed/simple;
	bh=Co2kGB+wRY7tpOUOLsuYM9DTdsAloPbvZVOcHFISJ8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIbmXvD2XN4g7LyA/ePfxzNFVJU7yftVz+3ouhj7o8+rZM+B+FG/DtYyjAfwJZi3jFmBSfKwYOyw29SxRLG8HoIJCnHoGkUFueQFGDxn5dm10Z1z/wIvaz5xdIj2u6K17AtYyPVcWW4wqS3P4ofN8gxjFGPG507LD7Knqt8AlLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Z5oKluK1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-227c7e57da2so54807305ad.0
        for <linux-ext4@vger.kernel.org>; Tue, 15 Apr 2025 16:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744759724; x=1745364524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ilFtG+6+Fot3Brak6oY8Uo8/2ZoDyUWu9EN85DUNHoc=;
        b=Z5oKluK1D1wu5ywFYpkLpETuVujDsSErtwyO70EpY+kBLxWLws1y/185KqN8nBpQSH
         1ommhY+U+UsP5xPKgYUjHJfiRsy+33IXcy1yBRKd4tH4FvjPNek929aA4E2XofqvaJhc
         u+daV9BM5eBcNM+cQ+P8FwFWFgyxgLg8NimUD4u2C2hDH+HYkXX9CfRqkD7mgontov92
         S4xl4gDNUU09/iQwhgyuxtu1/asI5Y6S5HubvHMPFrtk48zarOas3c5p6qxJI0SgHlbx
         uMo23kKMG/eEbfYjC917UjaU/ejE4H8hpsCcnAMKMsxsNRdpnod0tDf1qjiCIlaGu+NM
         dGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744759724; x=1745364524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilFtG+6+Fot3Brak6oY8Uo8/2ZoDyUWu9EN85DUNHoc=;
        b=j8xXiRztPC3b0Ot69fgUL0hrWPGKYjDvcloHTcnFw7ge1WKmnpRT3uazH5MMFSabG5
         pRZpvYUDqSN3KGj0pe2hO+orzHxEtQx5evcuzLUcZ1wVbph6Qxn0YuzRm5t+snYj8wzG
         eEEX5t+r44WXFSUddmd0f2J3j8MO97HPj4E6o1opw+oyQ7QvsBHd7G1Rk2v51VkJuiai
         WbHmAQQxwgKNnaf/0NXKi+B1gWrTIsMgLubsJnmXhjYie37vBPTfoxdPt3JFvn/08kkj
         kL0ZxUqnaBnvG2R6CME1WRrS04wKlP+mVp4G5ZTdxzyUy1BXT5bBRD9ZhwOZooGVD7ij
         9uJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwFmDucJBvfUgqddqrLWqjSnOQl+Av0xt6BtFgAC+JwRC+WV57z4wrIePJg59t/ECBOZYa4QM5tsE2@vger.kernel.org
X-Gm-Message-State: AOJu0YyizQUQOZIGhRFzZnD1OP8q3Pwx8sBlwPmDG/9LJm1iAEcadoFB
	1GB2wDP3ybbigGNHXN2vEYsY7f0rrvWtnuPpLLb3JUOKOy8cetyVJbpkSZMKGTY=
X-Gm-Gg: ASbGncuY2/HxY6IboFApNGfWwHJOCowxlFPXI8DmGAA6FpZe65muyfHNX3XP8Q16PRi
	cR8HqOIOKNACuDA7o8kJ1c8VILmUa7O/grVZTR0hbW5KIUyVMqIKL/vr8jand1fjB/EHBueZq3O
	CK9g+405DDxht0QZwrk8Mit25aPJ1+AekcECSnEgvKB2JPUMdP4GvEzCJaglEU7VK1SihL9N+Zh
	/VSXYTGgs3ocYrIgTmcJ23F4qnghuw+vplEvT0PrJ949cRSC1ajhETsAQj6TGPgUpx3rC54uVvo
	+QQqsVGv6yDRVlCWIopiQ3D5PPkfi5fSirdcou+5k0Y2IAHGb7fIqZ/wK5Mt4ZHxLLCmpUE+gqn
	J7sJrK2K37fuh0w==
X-Google-Smtp-Source: AGHT+IF5L5SnftugPGiVRbPyMGgy+P7lIDHpuADQTk5vv7bog6oS1bL9N/VLOKpi6CxPVttqXvRzRg==
X-Received: by 2002:a17:902:f68c:b0:224:160d:3f5b with SMTP id d9443c01a7336-22c31abfd00mr13818525ad.49.1744759724616;
        Tue, 15 Apr 2025 16:28:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fe9810sm943025ad.249.2025.04.15.16.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 16:28:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u4pho-000000095GN-1vHN;
	Wed, 16 Apr 2025 09:28:40 +1000
Date: Wed, 16 Apr 2025 09:28:40 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
	zlang@kernel.org
Subject: Re: [PATCH v2 2/3] check: Add -q <n> option to support unconditional
 looping.
Message-ID: <Z_7rqLbQCLAY5zbN@dread.disaster.area>
References: <cover.1743670253.git.nirjhar.roy.lists@gmail.com>
 <762d80d522724f975df087c1e92cdd202fd18cae.1743670253.git.nirjhar.roy.lists@gmail.com>
 <20250413214858.GA3219283@mit.edu>
 <9619fb07-1d2c-4f23-8a62-3c73ca37bec3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9619fb07-1d2c-4f23-8a62-3c73ca37bec3@gmail.com>

On Tue, Apr 15, 2025 at 01:02:49PM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 4/14/25 03:18, Theodore Ts'o wrote:
> > On Thu, Apr 03, 2025 at 08:58:19AM +0000, Nirjhar Roy (IBM) wrote:
> > > This patch adds -q <n> option through which one can run a given test <n>
> > > times unconditionally. It also prints pass/fail metrics at the end.
> > > 
> > > The advantage of this over -L <n> and -i/-I <n> is that:
> > >      a. -L <n> will not re-run a flakey test if the test passes for the first time.
> > >      b. -I/-i <n> sets up devices during each iteration and hence slower.
> > > Note -q <n> will override -L <n>.
> > I'm wondering if we need to keep the current behavior of -I/-i.  The
> > primary difference between them and how your proposed -q works is that
> > instead of iterating over the section, your proposed option iterates
> > over each test.  So for example, if a section contains generic/001 and
> > generic/002, iterating using -i 3 will do this:
> 
> Yes, the motivation to introduce -q was to:
> 
> 1. Make the re-run faster and not re-format the device. -i re-formats the
> device and hence is slightly slower.

Why does -i reformat the test device on every run in your setup?
i.e. if the FSTYP is not changing from iteration to iteration, then
each iteration should not reformat the test device at all. Unless, of
course, you have told it to do so via the RECREATE_TEST_DEV env
variable....

Hence it seems to me like this is working around some other setup or
section iteration problem here...

> 2. To unconditionally loop a test - useful for scenarios when a flaky test
> doesn't fail for the first time (something that -L) does.

That's what -i does. it will unconditionally loop over the specified
tests N times regardless of success or failure.

OTOH, -I will abort on first failure. i.e. to enable flakey tests
to be run until it eventually fails and leave the corpse behind for
debugging.

> So, are saying that re-formatting a disk on every run, something that -i
> does, doesn't have much value and can be removed?

-i does not imply that the test device should be reformatted on
every loop. If that is happening, that is likely a result of test
config or environment conditions.

Can you tell us why the test device is getting reformatted on every
iteration in your setup?

> > generic/001
> > generic/002
> > generic/001
> > generic/002
> > generic/001
> > generic/002
> > 
> > While generic -q 3 would do this instead:
> > 
> > generic/001
> > generic/001
> > generic/001
> > generic/002
> > generic/002
> > generic/002

There are arguments both for and against the different iteration
orders. However, if there is no overriding reason to change the
existing order of test execution, then we should not change the
order or test execution....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

