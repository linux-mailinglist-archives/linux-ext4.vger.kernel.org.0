Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBF2D0CB1
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2019 12:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfJIKUU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Oct 2019 06:20:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42813 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJIKUU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Oct 2019 06:20:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so1109169pgp.9
        for <linux-ext4@vger.kernel.org>; Wed, 09 Oct 2019 03:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0DrBaQnbYtrjFhbkpiALdni53TRw3sfJ8jYLri+SqV4=;
        b=ouZ6pOO/agM4GsrLN4pi0tnKoFsu9UjPHH8Vy6ezfb0B6aHXSiQV1PpnCAnHA890xK
         UeMShA/vOkO07GKl2aqY0wtYOKQNjdPb4jHGxsKxlqqb14FVd+nNhizxidQEOWs6GRhY
         sd4qEd6rDEz3r7ulIE4HND6FHb5D0FxeOm6ZIrR9nWvvQ5QJaPeLJGoJLfAdXpEdx9je
         v8se7n/+ZsIFMtexW9GN8V3F9y6+4nfK3yEEYjFEOdS0Hwe8sq9EYyMIZErWjzlI5Og3
         0Cu438emMfX/IB4VXBpvnTTWTBP4AWvuZ3jFc9JS/ZLRoIkwvjk61HAeTgbNxYGqTKu/
         yjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0DrBaQnbYtrjFhbkpiALdni53TRw3sfJ8jYLri+SqV4=;
        b=OrcndwSxMWSKxezDnSSfwDpNPzJjFR7KJ/vTtJWs25nE8/gKMnxmrxDmzUrfMlUtuo
         bIPRdt8s54FPi4uzoZPmrtZ/AjdE4zjqZbrx4IYeILtu86hxVIVR/ij/kHHiMoUsbsrD
         kHAceXkUOOjX5Nk0zSMOfcSe1pLDJ9YIw/IXfv5K5XgwqFRC2cLMzoKfPt3Y8xyigsgE
         av3J4Jk15stYcebL3d87JkJBtbvzna29hfUV3ohzebRchlsHif4/jJawBIKXybleVO33
         7pIdgD16W8hBlMN/IjLkNgzVJc16GawNdp3/SiHOMWKaa29LYG4VsWSUBzz2TY2X4ppT
         Z5pQ==
X-Gm-Message-State: APjAAAWO8ZP+Mngnxb6XKDqrECtX3YEKg+2l1T5DrPCQgFJeH1jPfpmx
        eePFEslTVEfvk/u/kjDhoMYz8wJbom1J
X-Google-Smtp-Source: APXvYqzAdKdlf9RrTcansEFvjlyYwjIu1XGuk+Swrm/brrIgNovaRuA5o0hFlrnwhnTRVVomDK5rWg==
X-Received: by 2002:a62:2f05:: with SMTP id v5mr2945334pfv.125.1570616419753;
        Wed, 09 Oct 2019 03:20:19 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id v1sm1820585pfg.26.2019.10.09.03.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:20:18 -0700 (PDT)
Date:   Wed, 9 Oct 2019 21:20:12 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 5/8] ext4: move inode extension/truncate code out from
 ->iomap_end() callback
Message-ID: <20191009102010.GA14749@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <da556191f9dba2b477cce57665ded57bfd396463.1570100361.git.mbobrowski@mbobrowski.org>
 <20191009062705.694BF42049@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009062705.694BF42049@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 09, 2019 at 11:57:04AM +0530, Ritesh Harjani wrote:
> On 10/3/19 5:04 PM, Matthew Bobrowski wrote:
> > In preparation for implementing the iomap direct I/O write path
> > modifications, the inode extension/truncate code needs to be moved out
> > from ext4_iomap_end(). For direct I/O, if the current code remained
> > within ext4_iomap_end() it would behave incorrectly. Updating the
> > inode size prior to converting unwritten extents to written extents
> > will potentially allow a racing direct I/O read operation to find
> > unwritten extents before they've been correctly converted.
> > 
> > The inode extension/truncate code has been moved out into a new helper
> > ext4_handle_inode_extension(). This function has been designed so that
> > it can be used by both DAX and direct I/O paths.
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> 
> checkpatch shows some whitespaces error in your comments
> in this patch.
> But apart from that, patch looks good to me.

Yeah, I will fix those.

> You may add:
> 
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks!

--<M>--
