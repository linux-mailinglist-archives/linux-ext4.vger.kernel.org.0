Return-Path: <linux-ext4+bounces-93-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE87F5361
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Nov 2023 23:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B10B20DBD
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Nov 2023 22:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A21121117;
	Wed, 22 Nov 2023 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="K1nmfMaY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D4712A
	for <linux-ext4@vger.kernel.org>; Wed, 22 Nov 2023 14:26:48 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ce3084c2d1so2093525ad.3
        for <linux-ext4@vger.kernel.org>; Wed, 22 Nov 2023 14:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1700692008; x=1701296808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EPKxp1wHu2X0l3z9q2thW4znkTvrAEpmGlqWbMXtNbI=;
        b=K1nmfMaYP9ss6mjH+3DHBwAgdllDAMo0MMMuwkTGvikGXypBIaRObThkDJC69ZnB5O
         oXaHdq3Ep1QJ9XyIqVvMYS7g7tS6ZJ15jqAQGL3ZfA/XfRU8VGgbd7h9+J5ZGM3TKKpj
         o+n7qmqabs/Yte/TRFSpHnLsOO2fTvpTcimM1/IkQq8RtDyhxRRetlHz92DncQgVFOEV
         8Flpmcx5FiQy6YEG/8TnRbg2z1S/0QoBdOfBPKM/jtHXbqa24H516H1O7T17dFenhRsO
         2hSLbcKuQk7mNYiTJx99ERf9q9nz+gQR1W4Kw+GW2czYW+1v+Y3D/J2moXhGkZdp2Iwr
         QzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700692008; x=1701296808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPKxp1wHu2X0l3z9q2thW4znkTvrAEpmGlqWbMXtNbI=;
        b=elltK48S1v6Ho86e+x19ZZQf7/jSjNBtfqKZkEPW3lSqjptuVJMMFEPAPiw11Oau2+
         8JB3yciOJx+5UOEepv1D1/s6gWuqZsJjTu4han5TGWVw0TWMjKUUyBDO0cxtrfQCqKVn
         q7HuMqQDQgddSN4xWUp8tG3uRd0f8OvwRr6fxxeNrQNMNtX6aGrk0nRtDEjhHCqg97/e
         V5yQXfvUPsbQpdRgXWXJ1431LWxBiPO4p11Om0dMS6iXplUa6SHSUmgtEmwdwsM3GPUB
         pwASmUX5doUuNmyGXl1aKXvBqIbFLH/fXUzHiZIRKSK77mzeqAm2OQYZN3liQ/RLIgNs
         yW3A==
X-Gm-Message-State: AOJu0Yx2ScZMZAFz0EKk+epPaIMVom3HcBIPQkrpRQwycJzSLJjt6NDj
	Mys7cvc9SgScf0jXNkufmOqz8wdUnWFXCZT4VVc=
X-Google-Smtp-Source: AGHT+IGJj4E4nSH8dpmDgva7z7MZT3uUEdfdUQu+dt8cC71QACDytNujG1h6BtgWAoV+3cpm75iHUw==
X-Received: by 2002:a17:902:ea8b:b0:1cf:8546:3376 with SMTP id x11-20020a170902ea8b00b001cf85463376mr1224073plb.5.1700692007804;
        Wed, 22 Nov 2023 14:26:47 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id ja21-20020a170902efd500b001cc47c1c29csm189754plb.84.2023.11.22.14.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:26:47 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1r5vgD-00GBwK-01;
	Thu, 23 Nov 2023 09:26:45 +1100
Date: Thu, 23 Nov 2023 09:26:44 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <ZV6AJHd0jJ14unJn@dread.disaster.area>
References: <cover.1700506526.git.ritesh.list@gmail.com>
 <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
 <20231122122946.wg3jqvem6fkg3tgw@quack3>
 <ZV399sCMq+p57Yh3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV399sCMq+p57Yh3@infradead.org>

On Wed, Nov 22, 2023 at 05:11:18AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 01:29:46PM +0100, Jan Kara wrote:
> > writeback bit set. XFS plays the revalidation sequence counter games
> > because of this so we'd have to do something similar for ext2. Not that I'd
> > care as much about ext2 writeback performance but it should not be that
> > hard and we'll definitely need some similar solution for ext4 anyway. Can
> > you give that a try (as a followup "performance improvement" patch).
> 
> Darrick has mentioned that he is looking into lifting more of the
> validation sequence counter validation into iomap.

I think that was me, as part of aligning the writeback path with
the ->iomap_valid() checks in the write path after we lock the folio
we instantiated for the write.

It's basically the same thing - once we have a locked folio, we have
to check that the cached iomap is still valid before we use it for
anything.

I need to find the time to get back to that, though.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

