Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2AADFA49
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2019 03:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfJVBzm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 21:55:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35840 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJVBzm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 21:55:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so9614894pfr.3
        for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2019 18:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rXswSMoB6Vxiulruunf+j1WjpnPVrwSDRmEMg90Vl74=;
        b=uBEd/EfMzezMsk6Y8W/1NSOiP78AqJj9abh7/QXDIjrhPVfdPpDGjO2RyzExzbL764
         nzfRaSRm+ehOA5Mi9MS/F2JmjVdDW/nlHgGjnWvxEmrOCQSZSR6TQ3B3jS8a7guPFEgS
         uyGNtAPzol1FP36zyzwWndKI8Kfl3dSZDY1umsbxy4FgIk53pZRcrqAS7VZuzd6D92t6
         9FMHUQoW5d+j64XcSqGLoBESRiGxXpriW4zVZgLMGIXveX9EKy8snTzNvrTxWqUvjfKB
         WMkyJiC4GFYGS/TmBTrs/c3kCozCV678bRcgirozfRpCEkD4NSPCOCogd4qYIqWIbADO
         C75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rXswSMoB6Vxiulruunf+j1WjpnPVrwSDRmEMg90Vl74=;
        b=MUSg0aeNGh2dTLS8YhirxfowHvIoBb1/x4bAQrpH1F+mWCDoabGq1sYxHqSWqs3Uxi
         xg7uikWR2WRfAARzxaQoZee6RhVt/5Dl43whwUJlyS+0Po+9o9HAH08tO/pzxt07tjjC
         TV3/zQouou7Vsaaw1nuBD3z4jijC/rxOnLFm2KvHKUe/+Gca6C3MTR0y5NYoAKzX/JGE
         A9kcy9hLOa16B84HtknahN40LowEgjM33glyftBVtM0NUnHyWQpnhz13BKg8lRujoE/5
         Fa8PsrDds0pa4rnrt7QY/GP0S7wbUOo8S5gFdqxazV1CF5/yF31uIa7MfXB25D4KoiEI
         IZlQ==
X-Gm-Message-State: APjAAAUUsXYIVthxhS/S6X3UHAGTdW7ozW7Hgr3RZQfVs3ANBQo90LiS
        xJChe7lntwExH+hdVlVUjxIL
X-Google-Smtp-Source: APXvYqwocGKZ1xwGxi8lbWo39SllcPl9fBSfPUwLygHvmL0pUXydyrcCdDSz0hsF9/AF7pE3jybx6Q==
X-Received: by 2002:a65:6701:: with SMTP id u1mr983201pgf.368.1571709341636;
        Mon, 21 Oct 2019 18:55:41 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id v2sm192596pjr.14.2019.10.21.18.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 18:55:40 -0700 (PDT)
Date:   Tue, 22 Oct 2019 12:55:35 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 04/12] ext4: introduce new callback for IOMAP_REPORT
Message-ID: <20191022015535.GC5092@athena.bobrowski.net>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <f82e93ccc50014bf6c47318fd089a035d8032b28.1571647179.git.mbobrowski@mbobrowski.org>
 <20191021133715.GD25184@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021133715.GD25184@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 21, 2019 at 03:37:15PM +0200, Jan Kara wrote:
> On Mon 21-10-19 20:18:09, Matthew Bobrowski wrote:
> One nit below.
> > +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
> > +				  map->m_lblk, end, &es);
> > +
> > +	if (!es.es_len || es.es_lblk > end)
> > +		return false;
> > +
> > +	if (es.es_lblk > map->m_lblk) {
> > +		map->m_len = es.es_lblk - map->m_lblk;
> > +		return false;
> > +	}
> > +
> > +	if (es.es_lblk <= map->m_lblk)
> 
> This condition must be always true AFAICT.

That would make sense. I will remove this condition in v6.

> > +		offset = map->m_lblk - es.es_lblk;
> > +
> > +	map->m_lblk = es.es_lblk + offset;
> > +	map->m_len = es.es_len - offset;
> > +
> > +	return true;
> > +}

--<M>--
