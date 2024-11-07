Return-Path: <linux-ext4+bounces-5002-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C62C19C109D
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 22:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D3BB26331
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755262281C6;
	Thu,  7 Nov 2024 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="O76z2ntA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231FC21949D
	for <linux-ext4@vger.kernel.org>; Thu,  7 Nov 2024 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013242; cv=none; b=FoIfxddhZBH1FhEmMQNq7MGjteYTP3vVcM7axt9VuKOudcT3yEO4OoVGbzs/R8p5L4VTSh9uU9F4OJqZTlxfBrt9htWEH78rYljvzyKdGqNRTnTfGXDyFsyHX+dIzt9qQFeHdlRy9teQnhxAz48Mkz0nIWpWOvvdd2G8IJTfBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013242; c=relaxed/simple;
	bh=glIxfpXz4rPGIVb35B1EK5oOug/SHSs+v3NHdJNM43w=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=qsWDhagRNM5hyXrsH0XgsKhUnXMnE3nv80JEiQfI+sGoKf7Ns+un1/rVauNlgWDIfYjF06s6xr4i4YFWepyLC49Hp6zbt+1bIa9JRLZvHv7fDCvfOizbWpIvBnD7lbb5nHVTo1haCmDlD6ZiRKcvfU1oxvWOXQTpYXrVh4DdGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=O76z2ntA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cb47387ceso15526415ad.1
        for <linux-ext4@vger.kernel.org>; Thu, 07 Nov 2024 13:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1731013238; x=1731618038; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5jRcxQ0kam/Te13bxZEHk23mNVeKOJMK0PD0l2nGuDk=;
        b=O76z2ntA55Nu6scF6rezrrGpMHmnI29q3/1gqwtj+7Dj5IJKRxK6mHCaZjoXwJR4u+
         v9duDbUkXhWrYrA1XuSiLMRwm4JLf1B1uQrASQDPF1APEQaHo87xcwgL0ChHZH7dHnda
         r0qOWUUrQPPbs3mjmTgtGvXY6Udry5ARib6mdhlkrga/xlvqphTAKliTulmOtv0ABJeZ
         70EAL5LEmvQfCm0McoCSEHymYUd/9HzrArMcAHN7lUvXsqAFANTP2ZYE3mAkvm+eQbOo
         JOpyXFOMRDxaqUwSSGkIkLBymWDlzDupvGFcLGVF4KvVpbLtNpAA+gaSE06Bq+IV4dyS
         2v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013238; x=1731618038;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jRcxQ0kam/Te13bxZEHk23mNVeKOJMK0PD0l2nGuDk=;
        b=u44cZJY3dxJ5bIGOkcef2UV6cAinxkdDq1Zl7YFh2iR6alVUO62PFlkWuHUp408Oip
         Pozsf7F9IKazXXrM5W09z6EYmTaLx7424UOjsWpms8l6AcemWt4trcIiRxLZFntpDO/4
         LVDVvC1EUX2HxNCMNZhwSO0GCOJWG/HH41z/eyeOZpVuqAI52NHZ4WHcmnJWu2Ul+ETz
         L/PL08B8WupxhEwCEsPHciWzbnbmY+MZiTARGVtXqDX5iKW3GlDXrxg3mnkzFXtNJah0
         8alEQDLJ9oKpp7p3CYKMYxJ/v60QxYjyguDPQ3/+zjWggB1RjsfdHHsL0y91GZQTsvBw
         G2LA==
X-Forwarded-Encrypted: i=1; AJvYcCXnvIFqfmioZXwPtqE9YRwwDNHC4BqKgRYaznk5DYR/CJ1F4fqWHJIn/l38H967vHCXMMjPtZR0DeNZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZRFP7I332MXNAZwiZxbMlQcuXVwfALlcWnL0uhiyg31IQMxM
	65dOZhnXybo3XkfCRISOpHe9I9gpbgXaND7ZtrW8b2VH1CTCmHkFOffEIhU/mmQ=
X-Google-Smtp-Source: AGHT+IGA7RMnP7tG9um/YAMku7rnQ8izRkwLDKiOWtq2gyRNsDRRtgUApcpGFE4IjYz95xqPUlnrog==
X-Received: by 2002:a17:90b:38ce:b0:2cb:4e14:fd5d with SMTP id 98e67ed59e1d1-2e9b173c84cmr817161a91.17.1731013238311;
        Thu, 07 Nov 2024 13:00:38 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a55bb19sm4032815a91.28.2024.11.07.13.00.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2024 13:00:37 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <52EF383A-7411-4DE8-90F7-8E943ABE26E6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_77B1F323-3B40-4AF5-A892-199FDA7D695F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH -next 0/3] ext4: Using scope-based resource management
 function
Date: Thu, 7 Nov 2024 14:00:34 -0700
In-Reply-To: <20241107041644.GE172001@mit.edu>
Cc: Li Zetao <lizetao1@huawei.com>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
References: <20240823061824.3323522-1-lizetao1@huawei.com>
 <20241107041644.GE172001@mit.edu>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_77B1F323-3B40-4AF5-A892-199FDA7D695F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Nov 6, 2024, at 9:16 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> On Fri, Aug 23, 2024 at 02:18:21PM +0800, Li Zetao wrote:
>> Hi all,
>> 
>> This patch set is dedicated to using scope-based resource management
>> functions to replace the direct use of lock/unlock methods, so that
>> developers can focus more on using resources in a certain scope and
>> avoid overly focusing on resource leakage issues.
>> 
>> At the same time, some functions can remove the controversial goto
>> label(eg: patch 3), which usually only releases resources and then
>> exits the function. After replacement, these functions can exit
>> directly without worrying about resources not being released.
>> 
>> This patch set has been tested by fsstress for a long time and no
>> problems were found.
> 
> Hmm, I'm torn.  I do like the simplification that these patches can
> offer.
> 
> The potential downsides/problems that are worrying me:
> 
> 1) The zero day test bot has flagged a number of warnings[1]
> 
> [1] https://lore.kernel.org/r/202408290407.XQuWf1oH-lkp@intel.com
> 
> 2) The documentation for guard() and scoped_guard() is pretty sparse,
>    and the comments in include/linux/cleanup.h are positively
>    confusing.  There is a real need for a tutorial which explains how
>    they should be used in the Documentation directory, or maybe a
>    LWN.net article.  Still, after staring that the implementation, I
>    was able to figure it out, but I'm bit worried that people who
>    aren't familiar with this construt which appears to have laned in
>    August 2023, might find the code less readable.
> 
> 3)  Once this this lands, I could see potential problems when bug fixes
>    are backported to stable kernels older than 6.6, since this changes
>    how lock and unlock calls in the ext4 code.  So unless
>    include/linux/cleanup.h is backported to all of the LTS kernels, as
>    well as these ext4 patches, there is a ris that a future (possibly
>    security) bug fix will result in a missing unlock leading to
>    hilarity and/or sadness.
> 
>    I'm reminded of the story of XFS changing the error return
>    semantics from errno to -errno, and resulting bugs when patches
>    were automatically backported to the stable kernels leading to
>    real problems, which is why XFS opted out of LTS backports.  This
>    patch series could have the same problem.... and I haven't been
>    able to recruit someone to be the ext4 stable kernel maintainers
>    who could monitor xfstests resullts with lockdep enabled to catch
>    potential problems.
> 
> That being said, I do see the value of the change
> 
> What do other ext4 developers think?

Personally I don't see much improvement between the new code vs.
the existing code.  Essentially it looks like some macros that wrap
the following block of code with the lock/unlock.

Could it avoid some classes of bugs?  Maybe, for very simple cases
where the code block is very short, but I don't think few-line bodies
are the cases where "forgot to unlock" happens in practice.  That is
more likely to happen with huge sprawling functions with multiple
intermediate error cases that need to be unwound, and it isn't clear
if these constructs will help in the real cases where they are needed.

Cheers, Andreas






--Apple-Mail=_77B1F323-3B40-4AF5-A892-199FDA7D695F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmctKnIACgkQcqXauRfM
H+Bu9Q/8DlCkNfpAYlSAoWp4QWNKDIsJ0wWRWpnK38ngyETRw7uo5HKNCBn+Ckta
1fyjPeu74zGSrXGGt92QczoXBiLQV8ptusCSdna6zFxEFvZ7Hd5d+bmvjAqsVzDY
dcYfJVOTB8BP29lK0jsMuyo6qzh7ivwTxCuXztcWyMpV/eVHJumQoMOBSl7HO0It
2SprLw1DZWX9uyhX6IzsAWiVnJXVFfe3Afn6/N6dbVlbmtZsMAgS+Lq7K/BGFDm/
/zk0eIgVZAlSXlwZd5wxNeWz/dXDofRk3R1IIuzMDqPJOPk3CmZXktydNOIcHCj3
0X0GrsG9N1Fc+4M451+7WNSAkcamNaHxlOEIbLfLyXjTOpBDQVRx4JmYNIjTetTe
Ayh/7+i7kglh9xf9Mm5gQEyVGsuHfZUhG2QHQCYuGvEns1uRDUV9dcZZeCG+jgF6
J/nRGLodEyOT8lkwmshl4omoYwOsUB6XHJrIMkBWiP4Pumea3A4/R0PnVT+iAWZp
Ov3prcjoVrLn7bUODrM9hlBPZJIhSLP86M2G3EeMUEdLigHyaCYLQIY1Wfp4Dh6U
Xw4nfA67Mlhc8nnhHdRorIqiAs4v718kWp0ucb2qD/5XJl3Qr9l47S1+IlL9lsEn
QEUhLhWx27X4tbb+D21b1AQpKLiEPK68t5LwSrNOiawiQAb+oYM=
=IV/n
-----END PGP SIGNATURE-----

--Apple-Mail=_77B1F323-3B40-4AF5-A892-199FDA7D695F--

