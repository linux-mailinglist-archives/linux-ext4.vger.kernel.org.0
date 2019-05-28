Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E092C791
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2019 15:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfE1NOD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 May 2019 09:14:03 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47466 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726887AbfE1NOD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 May 2019 09:14:03 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4SDDusN031713
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 09:13:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 976A8420481; Tue, 28 May 2019 09:13:56 -0400 (EDT)
Date:   Tue, 28 May 2019 09:13:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: fsync_mode mount option for ext4
Message-ID: <20190528131356.GB19149@mit.edu>
References: <20190528032257.GF10043@codeaurora.org>
 <20190528034007.GA19149@mit.edu>
 <20190528034830.GH10043@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528034830.GH10043@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 28, 2019 at 09:18:30AM +0530, Sahitya Tummala wrote:
> 
> Yes, but fsync_mode=nobarrier is little different than
> a general nobarrier option. The fsync_mode=nobarrier is
> only controlling the flush policy for fsync() path, unlike
> the nobarrier mount option which is applicable at all
> places in the filesystem.

What are you really trying to accomplish with fsync_mode=nobarrier?
And when does that distinction have a difference?

What sort of guarantees are you trying to offer, given a particular
hardware and software design?

I gather that fsync_mode=nobarrier means one of two things:

  * "screw you, application writer; your data consistency means nothing to me",

OR

  * "we have sufficient guarantees --- e.g., UPS/battery protection to
    guarantee that even if we lose AC mains, or the user press and holds
    the power button for eight seconds, we will give storage devices a
    sufficient grace period to write everything to persistent storage.  We
    also have the appropriate hardware to warn of an impending low-battery
    shutdown and software to perform a graceful shutdown in that eventuality."

If it's the latter, then nobarrier works just as well --- even better.

If it's the former, *why* is it considered a good thing to ignore the
requests of userspace?  And without any hardware assurances to provide
a backstop against power drop, do you care or not care about file
system consistency?

Why do you want the distinction between fsymc_mode=nobarrier and
nobarrier?  When would this distinction be considered a good thing?

	    	       	    		   - Ted












