Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B0ADFB52
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2019 04:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfJVCE3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 22:04:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36425 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730370AbfJVCE3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 22:04:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23so8960002pgk.3
        for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2019 19:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U8zC0pi58HNVgvXRenNwHhavuGCdq6iq04EqcnI0YUs=;
        b=hWHneUkVIlFf/L2jf24QvvpkHGg00gWSIVCG12Za7BdQfI2Sn5YkxZYiEPgJrH1olM
         3HF1ynjdPeNKpYGI9DKjN4+gQ857ec82EGR57N/0MjnMoRuwMctvyFsrD6zrysm1XbmK
         gP3QagMh7Vfyc5KLV0ZmCnuvjPbmxcFmn50A/Ow5X4Vm0SV9yE89jorAolYdALRonZ4w
         PhV6jd0wXz0PbpOLN0kyUK3Wawr959bg0mFOC8+uw4/heTPiR/6k0K3jM7vr1ppWxMkw
         +zvsC3Ff2oYB8a4PxB6AsbSq7JEcwwCWzjpK9WmYU6av7am08nLGb7uSnmuzzccMkPsG
         rwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U8zC0pi58HNVgvXRenNwHhavuGCdq6iq04EqcnI0YUs=;
        b=EA5gUwEcvusMFOcLpei/+iKBDQPfdaD702+Rlsltvpob67l/g9zLhDbmSQlzRvXD4A
         Cvt+k86e/tU2UwQ9WMXBgqoUJfEx7yiONbCUNeoyp8ni6xx1eolFXPcvSbcIjlGmAkkx
         5/ZSmogylgab2MAY0xa3q7ypG/TLjEYo1ghV4OI7wXFOq2mjtvlqFLTLKGjCHVhKOB9l
         XYMW+ys51H0gWV3FVEXtACbx6GYna0U54Aw2bz3zXlmaV23y1Tr1H8mq2c8tOBwVdfcl
         iv3IBpC+toYkPOeeuj3OA0llpStVOMRgxm416vRlnyKuYW/XhdVU9wJpMNR2znyPppqW
         4phA==
X-Gm-Message-State: APjAAAUR0grPtkWQTpc8BbsypBN9ePoLJ41Ah4foGvi5+eI45eKb3Laj
        5O3leMJmqGKMA6PEBZVnmx3Y
X-Google-Smtp-Source: APXvYqzFAkZsZIT8MOJGD07UTklnqavTHs8f2jsjcXVut8tJmT++SdYQES1hJLEcqsIl6DKqCJGEYg==
X-Received: by 2002:a17:90a:ec10:: with SMTP id l16mr1462745pjy.37.1571709868097;
        Mon, 21 Oct 2019 19:04:28 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id 127sm21245928pfw.6.2019.10.21.19.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 19:04:27 -0700 (PDT)
Date:   Tue, 22 Oct 2019 13:04:21 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 08/12] ext4: update direct I/O read to do trylock in
 IOCB_NOWAIT cases
Message-ID: <20191022020421.GE5092@athena.bobrowski.net>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <5ee370a435eb08fb14579c7c197b16e9fa0886f0.1571647179.git.mbobrowski@mbobrowski.org>
 <20191021134817.GG25184@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021134817.GG25184@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 21, 2019 at 03:48:17PM +0200, Jan Kara wrote:
> On Mon 21-10-19 20:18:46, Matthew Bobrowski wrote:
> > This patch updates the lock pattern in ext4_dio_read_iter() to only
> > perform the trylock in IOCB_NOWAIT cases.
> 
> The changelog is actually misleading. It should say something like "This
> patch updates the lock pattern in ext4_dio_read_iter() to not block on
> inode lock in case of IOCB_NOWAIT direct IO reads."
> 
> Also to ease backporting of easy fixes, we try to put patches like this
> early in the series (fixing code in ext4_direct_IO_read(), and then the
> fixed code would just carry over to ext4_dio_read_iter()).

OK, understood. Now I know this for next time. :)

Providing that I have this patch precede the ext4_dio_read_iter()
patch and implement this lock pattern in ext4_direct_IO_read(), am I
OK to add the 'Reviewed-by' tag?

--<M>--
