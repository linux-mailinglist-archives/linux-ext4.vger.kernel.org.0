Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD28F06F3
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 21:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfKEUcJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 15:32:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37900 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfKEUcI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Nov 2019 15:32:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so16687006pfp.5
        for <linux-ext4@vger.kernel.org>; Tue, 05 Nov 2019 12:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CXqKLplEg6QFJZFTjZZERaYQH2HOfWcmYOoVbXgDrYo=;
        b=ZZ4KzDbSDUnfjdiSr4ueKak6InnyZZT0EjdcNFWCU9zuCk+mxbpPoWVQvwIndVnoXv
         +rzNJYjXmR9sjSKIbOQyA58Q7cJq1Gu/2TDoL0HhMwN5T8ZFIP1IA2azWIQxYsLTUVi6
         0Bq5dewkmpugtQP9/pfDq5ZYCHv0zXEYipxhj2D2PLsO+uBNU58W2ZW+QRf26icZwvdA
         mpi2VwyguV420FGRuekjjaErHt/sudVEJuUq9WWdK5guNc8gW6Hlo0mO/+qxT5G8dpJK
         HwCfuV2m42nL05+A28xjeYQG67z3Djsx1rsbXRaLE/JlFgsoaK/4D0Y+88etk1JIBdRJ
         mNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CXqKLplEg6QFJZFTjZZERaYQH2HOfWcmYOoVbXgDrYo=;
        b=Kzff3dFloqv3bayiO4xJttH8Ro15C8afbsdEBunq6suPsu81jFVlsDPIAlNALRfmwg
         1OPIZsvdt1c/R78LSabaQgTCf2QrLJZb4l0G/KG1avXAMj7dl0OtHFfnPzkx2URqZfzO
         sVnMld0h8S+8UgBHVWk5nCvdCp1i1V6CbbGaGx4QVfdZU1ZbvfXCVua0VQkU09iDI5oZ
         zdKm2jRuhj0p71DPAhDF46xR5DXAhn/5eKlK/k6XfiPi9lneZbIVvtti/ho1X6Tzx5c1
         7fKMP/LuZPiDiKagLrksmQ1iziaj5SeiWA3MTvlSHZlzHEPauhCn9tRPP+/b3irLt5zH
         TktQ==
X-Gm-Message-State: APjAAAUTUKvVLfdQ2Q3i6Ie9ruPTTXt8oqGYLJZQhlc+8wZqp5M6C66J
        VB40e0VwHfQGnWtOCVWyxaTG
X-Google-Smtp-Source: APXvYqw/3eTcON5SJct+d5URgN+1AmMbZq3xLvPKPdKhEyP2EtoJi2NAzTEYm/hasUXn4J+aH7/uXQ==
X-Received: by 2002:a17:90a:35d0:: with SMTP id r74mr1186988pjb.47.1572985927720;
        Tue, 05 Nov 2019 12:32:07 -0800 (PST)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id h9sm294751pjh.8.2019.11.05.12.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 12:32:07 -0800 (PST)
Date:   Wed, 6 Nov 2019 07:32:00 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: Re: [PATCH v7 11/11] ext4: introduce direct I/O write using iomap
 infrastructure
Message-ID: <20191105203158.GA1739@bobrowski>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
 <e55db6f12ae6ff017f36774135e79f3e7b0333da.1572949325.git.mbobrowski@mbobrowski.org>
 <20191105135932.GN22379@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105135932.GN22379@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 05, 2019 at 02:59:32PM +0100, Jan Kara wrote:
> On Tue 05-11-19 23:02:39, Matthew Bobrowski wrote:
> > +	if (ret >= 0 && iov_iter_count(from)) {
> > +		ssize_t err;
> > +		loff_t endbyte;
> > +
> > +		offset = iocb->ki_pos;
> > +		err = ext4_buffered_write_iter(iocb, from);
> > +		if (err < 0)
> > +			return err;
> > +
> > +		/*
> > +		 * We need to ensure that the pages within the page cache for
> > +		 * the range covered by this I/O are written to disk and
> > +		 * invalidated. This is in attempt to preserve the expected
> > +		 * direct I/O semantics in the case we fallback to buffered I/O
> > +		 * to complete off the I/O request.
> > +		 */
> > +		ret += err;
> > +		endbyte = offset + ret - 1;
> 				   ^^ err here?
> 
> Otherwise you would write out and invalidate too much AFAICT - the 'offset'
> is position just before we fall back to buffered IO. Otherwise this hunk
> looks good to me.

Er, yes. That's right, it should rather be 'err' instead or else we
would write/invalidate too much. I actually had this originally, but I
must've muddled it up while rewriting this patch on my other computer.

Thanks for picking that up!

/M
