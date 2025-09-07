Return-Path: <linux-ext4+bounces-9838-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53043B47930
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Sep 2025 07:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C157A6927
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Sep 2025 05:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D4C1DF26A;
	Sun,  7 Sep 2025 05:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrOPIF9F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025431D6DDD
	for <linux-ext4@vger.kernel.org>; Sun,  7 Sep 2025 05:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757222994; cv=none; b=HZLvGreCZkq5RQ/MHkUcDcXl+L25dda2ejZIfXJ2xwcRLeqlROfT249ld6mXCfweGiIDMmVkM/8z1p4yDOR3iKnQNSPZ8tz7fOina4Ph8fQ7ZIDVw39P84p5bjaKZUvgp9OsOWdbPdniMJxijgYnyXjiLCehnpl35EmiLEqkeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757222994; c=relaxed/simple;
	bh=caTPKCkAvkuQGw3fUn3P6ZaPL/8hegzI2j/493ESBVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHi2LvofNcxpSS643rqwn5GF1UgVfhzleoLvhIZ4fSxvb93pwgnClMGK3MwRmhT3rLHjsZu1EA0LxylLW3jsA/WstOQxY/cd9cy31GvG67p1Wd/9WU+aEHL8s+Mqn7jGZsPqipsjmtpoTpVGtU04yJ9frykVDt0z7JHeXoTl14I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrOPIF9F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757222992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDSHjXOUY0OzHHbNYkSfv2EmWxAIktBkwdxNx3m1wgU=;
	b=RrOPIF9FT8TKjNfjnICyF9vVIE1d5J0AkYImR56vZtcrq8enmGkZv62gy3PpG92q/SJ8vU
	FA7i8vnHE1DTSCGebcYNK49/I5KW5YvXX49W7h2ESnF5OO94e4fnIHQPlEjbT9nD4wfLPy
	909haERKoVb832+pCTow8CUcJadBGFw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-ZmAM38KHNaufCJNKPBDuZA-1; Sun, 07 Sep 2025 01:29:50 -0400
X-MC-Unique: ZmAM38KHNaufCJNKPBDuZA-1
X-Mimecast-MFC-AGG-ID: ZmAM38KHNaufCJNKPBDuZA_1757222989
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4e1675ba95so2878852a12.1
        for <linux-ext4@vger.kernel.org>; Sat, 06 Sep 2025 22:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757222989; x=1757827789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDSHjXOUY0OzHHbNYkSfv2EmWxAIktBkwdxNx3m1wgU=;
        b=Ab/1KpTMPZKmQ4Rn0ur581hOlXcwylFxf+LDGsZwWNWlSiGeQrj3SHKHnKFhg6VKmE
         zpXqj8yEavRkMXOE7m31eJuVVb3JRBYb66WyBgNtHSMKsRNQ0nrVY/Rx5s3THLO3ss4Q
         ziYGYJpD5KlbOsyimIlW+KxJ4TCw5uVjPcXnn+pzueDF5UoD1I8cH2w8mEg84fQWCgU0
         6TTWeE6ARa+iv6NjS+GoMr/qrbmBTiFYeu7d0hNqLrpSicqG8BBScLb3Sv4yNnQMThs9
         lmQnb63BJR4++ZW0nkCO1kw6wcTxTl0qjCgQfTS7EjzO25+LUeR+p78f+44lqTCKHs8i
         JSUw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5OvIfxiyLxI4qlkYX31OZM7nIoua72+j/3pAhgMcR6O62OLKAyXAr9McTEGYqzAg1ox3TnPsZv0A@vger.kernel.org
X-Gm-Message-State: AOJu0YyyfghJ/Qz7rFZuqDT96aFwgu+UVkFFRS9kLKPaxLV5zXf8ucU0
	EHKn5J0DPDMU6oKQl5TUzNet8cjBGTwAyqRSeIgq4PkWJVCzqxgsFJq9D/wPPpDz4hgft4f1GiT
	+6y82n++GMqdUIbiWn9GHBKHeqHW0lMWI4C3F8g0ERuAt2C1Y8xmkqZopfzTjA2g=
X-Gm-Gg: ASbGncssrAnwvr6Ui4oizX5GzQQobL5Fl0sNcQTlHc7PJvVe60U0pfe7UnQFfZ0wNwp
	nLzhdWxh3vgCnXixkNeD5kAPQe2eFk7eTPTI4Z2qDEy8vA+7mn5g/mS2YYsiedu54uaauXZkDY6
	dXO37xq3Qv4SWck87vxn1sz6/1du9uSpVTqVe1llwwSqBeyrpmKOm770/OuOWes4H7D36Ua0PnE
	wGYUHguerzm10sDoqjMdGmW0pSjLjpebZad0cishHp9TWKwvzismG2jbDkYQhaBqPw3u+XjJSzG
	9ctMbnlmPDYUPSqizsVFR8IbrP1OtbjsT7v8mp4shMrAlwyG4XUjJWfYC8NmwgA3VmQpT8DJiO+
	a/cGH
X-Received: by 2002:a05:6a20:4303:b0:245:fc8e:ef5b with SMTP id adf61e73a8af0-24e7cc230b9mr12289009637.5.1757222989277;
        Sat, 06 Sep 2025 22:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvhkV+C/ngmYr5b9L+PxjVes3H9Tvgst7PxAuC8Mh5uWsBWo7Hp8B67gRI5Mjyth4C7Hk8+Q==
X-Received: by 2002:a05:6a20:4303:b0:245:fc8e:ef5b with SMTP id adf61e73a8af0-24e7cc230b9mr12288987637.5.1757222988895;
        Sat, 06 Sep 2025 22:29:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b520eaf013esm5307355a12.52.2025.09.06.22.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 22:29:48 -0700 (PDT)
Date: Sun, 7 Sep 2025 13:29:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <20250907052943.4r3eod6bdb2up63p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>

On Tue, Sep 02, 2025 at 03:50:10PM +0100, John Garry wrote:
> On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> > The main motivation of adding this function on top of _require_fio is
> > that there has been a case in fio where atomic= option was added but
> > later it was changed to noop since kernel didn't yet have support for
> > atomic writes. It was then again utilized to do atomic writes in a later
> > version, once kernel got the support. Due to this there is a point in
> > fio where _require_fio w/ atomic=1 will succeed even though it would
> > not be doing atomic writes.
> > 
> > Hence, add an explicit helper to ensure tests to require specific
> > versions of fio to work past such issues.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >   common/rc | 32 ++++++++++++++++++++++++++++++++
> >   1 file changed, 32 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 35a1c835..f45b9a38 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5997,6 +5997,38 @@ _max() {
> >   	echo $ret
> >   }
> > +# Check the required fio version. Examples:
> > +#   _require_fio_version 3.38 (matches 3.38 only)
> > +#   _require_fio_version 3.38+ (matches 3.38 and above)
> > +#   _require_fio_version 3.38- (matches 3.38 and below)
> 
> This requires the user to know the version which corresponds to the feature.
> Is that how things are done for other such utilities and their versions vs
> features?
> 
> I was going to suggest exporting something like
> _require_fio_atomic_writes(), and _require_fio_atomic_writes() calls
> _require_fio_version() to check the version.

(Sorry, I made a half reply in my last email)

This looks better than only using _require_fio_version. But the nature is still
checking fio version. If we don't have a better idea to check if fio really
support atomic writes, the _require_fio_version is still needed.
Or we rename it to "__require_fio_version" (one more "_"), to mark it's
not recommended using directly. But that looks a bit like a trick :-D

Thanks,
Zorro


> 
> Thanks,
> John
> 
> 


