Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387B4E1814
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 12:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391068AbfJWKf4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Oct 2019 06:35:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42210 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390935AbfJWKf4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Oct 2019 06:35:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id 21so1409738pfj.9
        for <linux-ext4@vger.kernel.org>; Wed, 23 Oct 2019 03:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IGCTYUdGZ/kAtactsj73D19FolPD9OqOn6a2pp38DL4=;
        b=ed00/wQ5b0JNduMCcXPzDHZ6hgztDx/0N7hnFnNKMPysVwKyUzx9tm5lQYb8wrp4vB
         t7zMj9n9I1QahJCKxDyggMRDo506VxsMpIJKPoPN2ao0zpjBm/D0QRt3Oa2V7GC1nlkS
         +2S/ut2fgYX/wpIXau+KOomw5Qu5ovPS3yF0L+BoaxPGqTOmSwvgMdl7L0B86ziHbIcc
         vDLIOc1oS/D9d538AXuX2qMkumVCaCzk2jhZUcpbwR3suwZGSK96V43yYVqvjYtr1Y0Y
         kxsG/Q6wrPkZWZNvpdsapThAcJ+72DrUn+YZaNttozeJVAbRuil97E1VCjv3Iyox20sN
         YDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGCTYUdGZ/kAtactsj73D19FolPD9OqOn6a2pp38DL4=;
        b=eQEGSJ1YTovC4EfzE7mdkHfWyxWMjTkEhiPKt00lUUt/iKFuDrZ3/Zx7QILsTNZL+j
         cLbE7U0ntFqliCvs0guIYNGsFhlrtX6eB9KSVC46UaaYQ3p2Rof278VvyoxFhsNesFtq
         NHHw47Yji231m6u3PoInXnNb/KuzhZRB3N0x+EOnAQnsd6oFIfC0+U9bPdiIKvhwR/Rv
         DmFbuM6lxUdu1x4QFOTuYkNvmRyw0zZzA2HoFlhRHN8IvQ6iFjZdnMucbxanxEbpqOs8
         NxW0BAqSZhkdWz+WuZzwBk7hBWg1K4ntL6pTDXYrr1Qs0jm+oFa1j3d22yefRa3wbnK9
         mn9w==
X-Gm-Message-State: APjAAAWBIsGu33DnRNI3Ypwby8aRh2iG3bVEde18x3jyg/zGpwjdsWQB
        pbNLL05BVgOsNXyvRrnJ2NmTb4sB0Lpt
X-Google-Smtp-Source: APXvYqxDN4nFg1E1mrSmBOqnqzfKhJ041UGZcDGwc6vrrRZBUb5u5S3KRYaqQyFtOHKfYdyLyYI2GA==
X-Received: by 2002:a17:90a:8505:: with SMTP id l5mr10774993pjn.41.1571826954909;
        Wed, 23 Oct 2019 03:35:54 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id c66sm3570020pfb.25.2019.10.23.03.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:35:54 -0700 (PDT)
Date:   Wed, 23 Oct 2019 21:35:48 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 04/12] ext4: introduce new callback for IOMAP_REPORT
Message-ID: <20191023103548.GD6725@bobrowski>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <f82e93ccc50014bf6c47318fd089a035d8032b28.1571647179.git.mbobrowski@mbobrowski.org>
 <20191021133715.GD25184@quack2.suse.cz>
 <20191022015535.GC5092@athena.bobrowski.net>
 <20191023063925.84F6C4C044@d06av22.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023063925.84F6C4C044@d06av22.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 23, 2019 at 12:09:24PM +0530, Ritesh Harjani wrote:
> On 10/22/19 7:25 AM, Matthew Bobrowski wrote:
> > On Mon, Oct 21, 2019 at 03:37:15PM +0200, Jan Kara wrote:
> > > On Mon 21-10-19 20:18:09, Matthew Bobrowski wrote:
> > > One nit below.
> > > > +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
> > > > +				  map->m_lblk, end, &es);
> > > > +
> > > > +	if (!es.es_len || es.es_lblk > end)
> > > > +		return false;
> > > > +
> > > > +	if (es.es_lblk > map->m_lblk) {
> > > > +		map->m_len = es.es_lblk - map->m_lblk;
> > > > +		return false;
> > > > +	}
> > > > +
> > > > +	if (es.es_lblk <= map->m_lblk)
> > > > +		offset = map->m_lblk - es.es_lblk;
> > > > +	map->m_lblk = es.es_lblk + offset;
> 
> And so, this above line will also be redundant.

And, you're absolutely right. Nice catch. Who knew basic math could go such a
long way? :P

Thanks Ritesh!

--<M>--
