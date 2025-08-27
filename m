Return-Path: <linux-ext4+bounces-9708-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6491CB385A3
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 17:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197DB5E0C2E
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 15:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA9A26F2AB;
	Wed, 27 Aug 2025 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jj8xIwc+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B9426F2A2
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306946; cv=none; b=fV2NShiQFXoGMnxtkbwINijzlJHqhJGwDyKMI8FN09LjiOKydONwn+LXVRCT1PkO5ckSibUNjIyBV8Yf0+OI/kNFco5ZurwZOV7IrW/93F/RCmD3BzI6zCjreXV2SQTw0DkVScOc0Fy7GNICOXamK/aj+FoC/Hq5S55DzQyLri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306946; c=relaxed/simple;
	bh=p7Femr3MH0SjlXMwhy+YuUVugyvqfq1RJmpvLJsYpAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cgh5cpFHtfVI6IviQCu4x48bpu4yaJnMAJTxbP39bcgPU6cQmGdwHzq/4aXhQhBQtGxO6Nrvovdo6U2tFxnMgQt/jfah4ltlYK8z7kQs3p/zIVhLYNHXrL0DnODHTW7r2X7nCSdN+HfThVl82MapDH59n2w7jTf4SipHX9eAW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jj8xIwc+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-771eecebb09so3544930b3a.3
        for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756306944; x=1756911744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4OCXs+jnWwR7FWJtHtpNrO1FLD08aYIad5UriCvf31Q=;
        b=jj8xIwc+sA0fjj7TYNDCH/6/FotdWStvGr3ltrFqbBN6n972PejFaZ/WC/WX3tt+5B
         RJDu8oDY+1GFjxRH2BTEkL0pdU93ec3Pk/mA/Bdh+x92f/xoDGnT3URMcPEgNewDG0z3
         15r2W/UDqtxSrBX3TtUL7Q5TTH+Do25dVS3XJ/mDjG+UieEeaFiUha2AqzIMAWizrMiP
         +HhRS0kv6jsB0sy3WtHElezy+5GAh4LHfezl1KddW9S0KNun67VaWt27nlzLkB/Wxg19
         M5TC0BWKzB+kM70wz3hE7rS2gswJHCPKzQEbiCTH1BRgoI09a0MUDQCpQcdE9+br6ILw
         4Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756306944; x=1756911744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OCXs+jnWwR7FWJtHtpNrO1FLD08aYIad5UriCvf31Q=;
        b=PnlCtW90y98Kh/VSuaOdb2WNVjOgi0It0PPoNqH2z9g9ge4XF1CCkjUaJGvCYIRDAz
         n9wpY+jdamVjxQguQh8Kjv6sntD56MPrN6OwVDuNH47BoGhGcyvdQOBghmdVX3zzjVCF
         DNFnuAy59FpiozIEleq2Ljf3WwkBDywYRItzoGLo90Fu35p37BZWgbxOxACimlvzVhiN
         s+s0X1ks7GkSBxNJlXoFUI8YU36N2TLSkya+cXbRUbvdHumk91Be+zjL8h8s1f/RTFXO
         mMF+liDt6rd+34/loif6ZXPa+KlH533NMLatKQOqlGD59bcoAj9iB9CUpFeUSdVtsGbw
         Rbvg==
X-Forwarded-Encrypted: i=1; AJvYcCW9Hj2b99kzf0USwln2BRzCPapE9x4XomuJ2VWzzPuZjvPDoJIinflof3NOsywkLn+wK+f0A9C/pD9v@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaICvYKIx6EJWa9dXnhyHse20HTF92eQcossR5HoZ6jGZgqwe
	gAuArPPmfXrQh2fgTAEjRbWmK4yVaWIUNfLm3tMUS7BWsuFm0Mvrz1GaUnL77LmTzMsSynu3RWF
	z4Bpd
X-Gm-Gg: ASbGncv72/utHJx9KI+LmwMtqeZmWRuN3qW2Y1j6NEHGc5Sz5BxMB4j6IbHCA4ppYFD
	cRKX0crNM2bEG4L1ORzBl5ROmEpxw2GRZkZtGhTUZTf2v/YLcWdfMbyHLmh8uQhZuEjwMnoZp+z
	Zcd+PAR8xDbFRF7i8vMjAqiHx+3bBIT625CdHiIW8e4tsqYvAw7xUaUf3RSdFJe2P0vlxsTPfDm
	0mcYUJZSAou/NuHW90I2Gw06DcBP9x8rmPh5nC/PqoHFUGJPAPcFwJQHVhQwArDCT6jKE7wwGsN
	YIACQRlPQtvnoxqSGoRE4NFHXuuI53mmo4Hq3ZG+d5WFRZVoLb+Dh+2swcMcZVA83uXyKjmFe6+
	9Z7SRl5N21o+f39VWjuUwmJ9h1XXukKCqI9VziZxfQZswsdx4zL+mEEy81FY=
X-Google-Smtp-Source: AGHT+IFyYOwHMJoEXmOQ8uGAH/l+ZKAO0DrXblFReatS3WwuC7vhpTGGm7wAutkG59wh9SZ1OWY6PQ==
X-Received: by 2002:a05:690c:6805:b0:71f:95ce:ac82 with SMTP id 00721157ae682-71fdc2a89e0mr220525927b3.9.1756306491322;
        Wed, 27 Aug 2025 07:54:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72151e8f522sm1970907b3.3.2025.08.27.07.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:54:50 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:54:49 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 03/54] fs: rework iput logic
Message-ID: <20250827145449.GA2271493@perftesting>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <be208b89bdb650202e712ce2bcfc407ac7044c7a.1756222464.git.josef@toxicpanda.com>
 <rrgn345nemz5xeatbrsggnybqech74ogub47d6au45mrmgch4d@jqzorhulkvre>
 <n6z2jkdgmgm2xfxc7y3a2a7psnkeboziffkt6bjoggrff4dlxe@vpsyl3ky6w6v>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n6z2jkdgmgm2xfxc7y3a2a7psnkeboziffkt6bjoggrff4dlxe@vpsyl3ky6w6v>

On Wed, Aug 27, 2025 at 04:18:55PM +0200, Mateusz Guzik wrote:
> On Wed, Aug 27, 2025 at 02:58:51PM +0200, Mateusz Guzik wrote:
> > On Tue, Aug 26, 2025 at 11:39:03AM -0400, Josef Bacik wrote:
> > > Currently, if we are the last iput, and we have the I_DIRTY_TIME bit
> > > set, we will grab a reference on the inode again and then mark it dirty
> > > and then redo the put.  This is to make sure we delay the time update
> > > for as long as possible.
> > > 
> > > We can rework this logic to simply dec i_count if it is not 1, and if it
> > > is do the time update while still holding the i_count reference.
> > > 
> > > Then we can replace the atomic_dec_and_lock with locking the ->i_lock
> > > and doing atomic_dec_and_test, since we did the atomic_add_unless above.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > >  fs/inode.c | 23 ++++++++++++++---------
> > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index a3673e1ed157..13e80b434323 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -1911,16 +1911,21 @@ void iput(struct inode *inode)
> > >  	if (!inode)
> > >  		return;
> > >  	BUG_ON(inode->i_state & I_CLEAR);
> > > -retry:
> > > -	if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
> > > -		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > > -			atomic_inc(&inode->i_count);
> > > -			spin_unlock(&inode->i_lock);
> > > -			trace_writeback_lazytime_iput(inode);
> > > -			mark_inode_dirty_sync(inode);
> > > -			goto retry;
> > > -		}
> > > +
> > > +	if (atomic_add_unless(&inode->i_count, -1, 1))
> > > +		return;
> > > +
> > > +	if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > > +		trace_writeback_lazytime_iput(inode);
> > > +		mark_inode_dirty_sync(inode);
> > > +	}
> > > +
> > > +	spin_lock(&inode->i_lock);
> > > +	if (atomic_dec_and_test(&inode->i_count)) {
> > > +		/* iput_final() drops i_lock */
> > >  		iput_final(inode);
> > > +	} else {
> > > +		spin_unlock(&inode->i_lock);
> > >  	}
> > >  }
> > >  EXPORT_SYMBOL(iput);
> > > -- 
> > > 2.49.0
> > > 
> > 
> > This changes semantics though.
> > 
> > In the stock kernel the I_DIRTY_TIME business is guaranteed to be sorted
> > out before the call to iput_final().
> > 
> > In principle the flag may reappear after mark_inode_dirty_sync() returns
> > and before the retried atomic_dec_and_lock succeeds, in which case it
> > will get cleared again.
> > 
> > With your change the flag is only handled once and should it reappear
> > before you take the ->i_lock, it will stay there.
> > 
> > I agree the stock handling is pretty crap though.
> > 
> > Your change should test the flag again after taking the spin lock but
> > before messing with the refcount and if need be unlock + retry.
> > 
> > I would not hurt to assert in iput_final that the spin lock held and
> > that this flag is not set.
> > 
> > Here is my diff to your diff to illustrate + a cosmetic change, not even
> > compile-tested:
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 421e248b690f..a9ae0c790b5d 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1911,7 +1911,7 @@ void iput(struct inode *inode)
> >  	if (!inode)
> >  		return;
> >  	BUG_ON(inode->i_state & I_CLEAR);
> > -
> > +retry:
> >  	if (atomic_add_unless(&inode->i_count, -1, 1))
> >  		return;
> >  
> > @@ -1921,12 +1921,19 @@ void iput(struct inode *inode)
> >  	}
> >  
> >  	spin_lock(&inode->i_lock);
> > +
> > +	if (inode->i_count == 1 && inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > +		spin_unlock(&inode->i_lock);
> > +		goto retry;
> > +	}
> > +
> >  	if (atomic_dec_and_test(&inode->i_count)) {
> > -		/* iput_final() drops i_lock */
> > -		iput_final(inode);
> > -	} else {
> >  		spin_unlock(&inode->i_lock);
> > +		return;
> >  	}
> > +
> > +	/* iput_final() drops i_lock */
> > +	iput_final(inode);
> >  }
> >  EXPORT_SYMBOL(iput);
> >  
> 
> Sorry for spam, but the more I look at this the more fucky the entire
> ordeal appears to me.
> 
> Before I get to the crux, as a side note I did a quick check if atomics
> for i_count make any sense to begin with and I think they do, here is a
> sample output from a friend tracing the ref value on iput:
> 
> bpftrace -e 'kprobe:iput /arg0 != 0/ { @[((struct inode *)arg0)->i_count.counter] = count(); }'
> 
> @[5]: 66
> @[4]: 4625
> @[3]: 11086
> @[2]: 30937
> @[1]: 151785
> 
> ... so plenty of non-last refs after all.
> 
> I completely agree the mandatory ref trip to handle I_DIRTY_TIME is lame
> and needs to be addressed.
> 
> But I'm uneasy about maintaining the invariant that iput_final() does
> not see the flag if i_nlink != 0 and my proposal as pasted is dodgy af
> on this front.
> 
> While here some nits:
> 1. it makes sense to try mere atomics just in case someone else messed
> with the count between handling of the dirty flag and taking the spin lock
> 2. according to my quick test with bpftrace the I_DIRTY_TIME flag is
> seen way less frequently than i_nlink != 0, so it makes sense to swap
> the order in which they are checked. Interested parties can try it out
> with:
> bpftrace -e 'kprobe:iput /arg0 != 0/ { @[((struct inode *)arg0)->i_nlink != 0, ((struct inode *)arg0)->i_state & (1 << 11)] = count(); }'
> 3. touch up the iput_final() unlock comment
> 
> All that said, how about something like the thing below as the final
> routine building off of your change. I can't submit a proper patch and
> can't even compile-test. I don't need any credit should this get
> grabbed.

Thanks for this Mateusz, you're right I completely changed the logic by not
doing this under the i_lock.  This update looks reasonable to me, thank you for
the analysis and review!

Josef

