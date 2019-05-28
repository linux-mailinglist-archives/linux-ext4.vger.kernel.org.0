Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9C722BDF1
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2019 05:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfE1Dsh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 May 2019 23:48:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35672 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfE1Dsg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 May 2019 23:48:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C6F0161197; Tue, 28 May 2019 03:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559015315;
        bh=JHVJxQQnV3axv68Tgy3wpB7YfFg/VyjxcO8HY+jSF+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0ZChJiKb/6eHP2/4QtOz0DBJoVI6zjf736TZ8rOqlTQBXeCLPvuXO6z8oJ2rtCYT
         TZZ6chA0mLdL2+cJV04xQE/7HgXo9kEPihXOU7JlOJCAYSiPB+CeJmtj9BcJp3OCS+
         mVI4dGA9jQ0xlAmS5LpcWngPqZlqMjQv3ZAdm7vE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5A6160F3A;
        Tue, 28 May 2019 03:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559015315;
        bh=JHVJxQQnV3axv68Tgy3wpB7YfFg/VyjxcO8HY+jSF+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0ZChJiKb/6eHP2/4QtOz0DBJoVI6zjf736TZ8rOqlTQBXeCLPvuXO6z8oJ2rtCYT
         TZZ6chA0mLdL2+cJV04xQE/7HgXo9kEPihXOU7JlOJCAYSiPB+CeJmtj9BcJp3OCS+
         mVI4dGA9jQ0xlAmS5LpcWngPqZlqMjQv3ZAdm7vE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5A6160F3A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Tue, 28 May 2019 09:18:30 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: fsync_mode mount option for ext4
Message-ID: <20190528034830.GH10043@codeaurora.org>
References: <20190528032257.GF10043@codeaurora.org>
 <20190528034007.GA19149@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528034007.GA19149@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Mon, May 27, 2019 at 11:40:07PM -0400, Theodore Ts'o wrote:
> On Tue, May 28, 2019 at 08:52:57AM +0530, Sahitya Tummala wrote:
> > Hi Ted, Andreas,
> > 
> > Do you think this mount option "fsync_mode=nobarrier"
> > can be added for EXT4 as well like in F2FS? Please
> > share your thoughts on this.
> > 
> > https://lore.kernel.org/patchwork/patch/908934/
> 
> Ext4 already has the nobarrier mount option.
> 

Yes, but fsync_mode=nobarrier is little different than
a general nobarrier option. The fsync_mode=nobarrier is
only controlling the flush policy for fsync() path, unlike
the nobarrier mount option which is applicable at all
places in the filesystem.

Thanks,

> Cheers,
> 
>      	     	     	       	     - Ted

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
