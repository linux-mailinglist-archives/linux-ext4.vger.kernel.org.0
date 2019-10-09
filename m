Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B11FBD0B85
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2019 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfJIJlh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Oct 2019 05:41:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35298 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfJIJlh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Oct 2019 05:41:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id c3so800896plo.2
        for <linux-ext4@vger.kernel.org>; Wed, 09 Oct 2019 02:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RYuDZIbrxz2iKnv5yp3/syqgU8z4sOzoL7hyUzZxM38=;
        b=lAbaWFNgu4uShqU246OAkXYF0FcdcnRRiE/h9BVKlEKUFiy5lkfUXZLspVdb3dVUJA
         +YdW6zkHmmdDCLfcT5W2qI3gkeDRlRIu5TQvmYwq355FFMd/DXWlB6wO6gJdQej6AaCd
         BWorwU4s4/P/uvO6bdy7Edsusl9MwO0B+JR5GFRvfuBCjW9eDhmTKPtuPg9mTNGW1avP
         r9qr8e6IPa0wP5obzlNqb0tG/ADdatVMTFJ/Gib/j9qHl4d/qKdIySZHt7HiFaWOpNFK
         qHIN6NGitN4rTx5XREFR2UvHeiuLd0dOAo80TBYs61VkzIzmYUr/6/iRfgXDZLPWUEES
         Zdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RYuDZIbrxz2iKnv5yp3/syqgU8z4sOzoL7hyUzZxM38=;
        b=Yo/5tGpLpuvsMHhcElvwQ8MnWtuGcmOkKF9GOWYC4SmGPTEQ/n05eM4Wzg5kzN5h78
         2KLQzJgGWST/2jOGgLhBFZ2QXOLcZ6bmTpRvwsDlrGoC7Z1Q4/kvOyiRfDemY4u3oA+0
         aJw+20EZKzt5fTcDsaV2s4vY9FF6RK0F9SFI3YMDQa1wX5IW7ibp1ldzuehQZKGWKsdn
         E5YDI87Ty8JWb7aT3LdrsSjIc8wEB6YqSWsNfdubrmdK5lgf7NyXLC6cXpBHrHqQLGC2
         SwESnRxB0XuMumZSjWI/fdym1FgrjEKvsOJOltWF6FI0Xxpg6Fq161DSwX7IUa59FDb9
         HuCQ==
X-Gm-Message-State: APjAAAUAuLvjcFgsn0Kvz5+Gp+1QShWSL1qwQC2YO+QJv9/vuUnlcdUZ
        6VzIEHn+qLsXYgHuHaoDpAgB
X-Google-Smtp-Source: APXvYqyyHs6+SkSLXsA54uaQQXNXij8vzZKubO8h1rBCfzJ+cC/SBsuRBVIkeOL5IhhXP2qzF5CU5Q==
X-Received: by 2002:a17:902:b94b:: with SMTP id h11mr2240419pls.21.1570614096362;
        Wed, 09 Oct 2019 02:41:36 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id c11sm2255972pfj.114.2019.10.09.02.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 02:41:35 -0700 (PDT)
Date:   Wed, 9 Oct 2019 20:41:29 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 3/8] ext4: introduce new callback for IOMAP_REPORT
 operations
Message-ID: <20191009094128.GF2125@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <cb2dcb6970da1b53bdf85583f13ba2aaf1684e96.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008104209.GF5078@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008104209.GF5078@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 08, 2019 at 12:42:09PM +0200, Jan Kara wrote:
> On Thu 03-10-19 21:33:45, Matthew Bobrowski wrote:
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks Jan! :)

> It would just need small adjustments if you change patch 1 as I suggested:

I will await what you say in response to what my thoughts were aronud
ext4_set_iomap() before doing any updates here.

> > +static u16 ext4_iomap_check_delalloc(struct inode *inode,
> > +				     struct ext4_map_blocks *map)
> > +{
> > +	struct extent_status es;
> > +	ext4_lblk_t end = map->m_lblk + map->m_len - 1;
> > +
> > +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, map->m_lblk,
> > +				  end, &es);
> > +
> > +	/* Entire range is a hole */
> > +	if (!es.es_len || es.es_lblk > end)
> > +		return IOMAP_HOLE;
> > +	if (es.es_lblk <= map->m_lblk) {
> > +		ext4_lblk_t offset = 0;
> > +
> > +		if (es.es_lblk < map->m_lblk)
> > +			offset = map->m_lblk - es.es_lblk;
> > +		map->m_lblk = es.es_lblk + offset;
> > +		map->m_len = es.es_len - offset;
> > +		return IOMAP_DELALLOC;
> > +	}
> > +
> > +	/* Range starts with a hole */
> > +	map->m_len = es.es_lblk - map->m_lblk;
> > +	return IOMAP_HOLE;
> > +}
> 
> This function would then be IMO better off to directly update 'iomap' as
> needed after ext4_set_iomap() sets hole there.

As mentioned in 1/8, it would be nice to leave all iomap setting up to
ext4_set_iomap(), but if we're strongly against passing 'type', then
I'm happy to change it and update this to pass an 'iomap'.

--<M>--
