Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C691E22A5
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 20:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbfJWSnd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Oct 2019 14:43:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:60804 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfJWSnd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Oct 2019 14:43:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 11:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="228226724"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga002.fm.intel.com with ESMTP; 23 Oct 2019 11:43:33 -0700
Date:   Wed, 23 Oct 2019 11:43:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: fix signed vs unsigned comparison in
 ext4_valid_extent()
Message-ID: <20191023184332.GC7689@iweiny-DESK2.sc.intel.com>
References: <20191023013112.18809-1-tytso@mit.edu>
 <20191023054447.GE361298@sol.localdomain>
 <20191023131546.GB2460@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023131546.GB2460@mit.edu>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 23, 2019 at 09:15:46AM -0400, Theodore Y. Ts'o wrote:
> On Tue, Oct 22, 2019 at 10:44:47PM -0700, Eric Biggers wrote:
> > 
> > This patch can't be fixing anything because the comparison is unsigned both
> > before and after this patch.
> 
> Thanks, you're right; I had forgotten C's signed/unsigned rules for
> addition.  The funny thing is the original reporter of BZ #205197
> reported that the problem went away he tried a similar patch.

Not trying to stick my nose in too much here but:

What does it mean if ext4_ext_get_actual_len() to return < 0?

Ira

> 
> 	      	  	       	    - Ted
