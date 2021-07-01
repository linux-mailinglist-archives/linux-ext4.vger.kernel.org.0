Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688453B9383
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Jul 2021 16:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhGAOoU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Jul 2021 10:44:20 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53919 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232363AbhGAOoT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Jul 2021 10:44:19 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 161Efi7i026069
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jul 2021 10:41:44 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D564C15C3CE1; Thu,  1 Jul 2021 10:41:43 -0400 (EDT)
Date:   Thu, 1 Jul 2021 10:41:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 1/2] fs: ext4: Consolidate checks for resize of bigalloc
 into ext4_resize_begin
Message-ID: <YN3UJ5Pmq3tz9xOv@mit.edu>
References: <bee03303d999225ecb3bfa5be8576b2f4c6edbe6.1623093259.git.josh@joshtriplett.org>
 <YNSVUy/DTWdhzuci@mit.edu>
 <YN0QxMh7ymC8obre@mit.edu>
 <YN0lzsMfCWli9Qp+@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN0lzsMfCWli9Qp+@localhost>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 30, 2021 at 07:17:50PM -0700, Josh Triplett wrote:
> Sorry to have missed the third case here, and no problems with the
> revert. I'm hoping that the second patch can be kept as-is, assuming
> there's no support for resizing sparse_super2 by any code path?

No worries, I missed it too in my review.  Yes, I only reverted the
first patch, and kept the second one.  There was a minor conflict in
the revert, but it was easily fixed up.

    	    	       	      	    - Ted
