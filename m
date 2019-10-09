Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6AFD0CB3
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2019 12:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfJIKVU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Oct 2019 06:21:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35445 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbfJIKVU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Oct 2019 06:21:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so1345360pfw.2
        for <linux-ext4@vger.kernel.org>; Wed, 09 Oct 2019 03:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NGIndCTE8KhRZkb8ZPgdgTbFHphaWq58jb9K01Ql4oU=;
        b=lq8wCc3W0v2Lwy6WeHgT0dVxquyu04Lfc/iCrFMlaJdXmIWYGk2sdXy5fnniCVsvl9
         jpMr7ZbIvJoJ/AwwPFXSwOMcpnAmCnlbXzxquDyF4P5g4PWPH4MPSdhTacq0Kqo8Yq/f
         1Y1KemAcYRsD0T+gkYSjWgBY9sPsGVd/Qf08DghHLVdg+rOcoc4yfUvXM9IVRr9jUkXJ
         e10aQkvBrwhuanpXMs+BFnM+/cc6i00GoCAPBVY+bEkoLzvodJkeqaMVo3CPAsr7KE0h
         p4Cd8edZmIAnRgjomjcsqxs0k+qW0/P33la563+IfrsHXuQfcirZbRnaSyOzGkm/1Pmt
         mMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NGIndCTE8KhRZkb8ZPgdgTbFHphaWq58jb9K01Ql4oU=;
        b=XuiUFGbTFbqx8ViIzlySBxiMLSunivjdHA2xllEU1QHIfjlAKowE/1t3Lna4rm+s+0
         zcgM1xwADjtQDdAvFVddVyTI4ZZc3wY/j8+x+KlIUkXqIFOejSVAwrPgrqwlHTetnkb2
         QcJsgB6EEvhZ1DRMWn+mn+rr8X19qeksNX84GLWSvYekZhKoE0fJ407WadzqgM4+/nJT
         7KcgyzVD7tQINa5o2I4Mci9Hm8BP85B56DM0dZyphc1UIIiIEChPFMrMKhM5q/xDaACT
         chlQ2cWdSct5jD/LeBrdjyvYbkfft2wYfv6Ct2u09drRTsWVmzo9Cxyxuo1AT5mpBPeH
         yXrw==
X-Gm-Message-State: APjAAAWXdM64fKuFDbWAa0SaSqPkUF5ZTso7A1i/nZpnZ6x1pqxUTaw0
        CcwAAL0v2d/baTue5CODKAg5
X-Google-Smtp-Source: APXvYqyWiwK/8Pz8taSMnqYN0BB0XGDTtn01LCq7sXhZ+yX4xt8c1eUES5eFMYgqzWbkSBbBwA0LKQ==
X-Received: by 2002:a65:5ac4:: with SMTP id d4mr3362341pgt.181.1570616479946;
        Wed, 09 Oct 2019 03:21:19 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id e4sm1717785pff.22.2019.10.09.03.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:21:19 -0700 (PDT)
Date:   Wed, 9 Oct 2019 21:21:13 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 6/8] ext4: move inode extension checks out from
 ext4_iomap_alloc()
Message-ID: <20191009102111.GB14749@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <d1ca9cc472175760ef629fb66a88f0c9b0625052.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008112706.GI5078@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008112706.GI5078@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 08, 2019 at 01:27:06PM +0200, Jan Kara wrote:
> On Thu 03-10-19 21:34:36, Matthew Bobrowski wrote:
> > We lift the inode extension/orphan list handling logic out from
> > ext4_iomap_alloc() and place it within the caller
> > ext4_dax_write_iter().
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> 
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks Jan! :)

--<M>--
