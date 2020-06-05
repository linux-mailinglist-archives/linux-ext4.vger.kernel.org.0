Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCF71EF02E
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 06:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFEEMU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 00:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgFEEMU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 5 Jun 2020 00:12:20 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC6C020738;
        Fri,  5 Jun 2020 04:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591330340;
        bh=mmrq5v566S0ymXz37EQnEZeSdcsbREkX3mfDgv0rFOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fASrVMkR9WFDMrIeOlgmMXrOEkYoX9ubdIQqqTFEHQe/ENUlB8DGsU39N7ZcDplQn
         /3vxVj0eKjJr2PQlgbhilgD5B3XRUhHyo5ZcAl9CIhIBJccBnLf1ibX8gpvaPI64Is
         az+tJLmCRGepv8DjJfc0Xmy5HgdoeG3bSbjw06lM=
Date:   Thu, 4 Jun 2020 21:12:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu,
        syzbot <syzbot+aed048f49c59eb997737@syzkaller.appspotmail.com>
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: systemd-rfkill/6728
Message-ID: <20200605041218.GD2667@sol.localdomain>
References: <000000000000a7be4a05a74ca69a@google.com>
 <20200605040220.GB2667@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605040220.GB2667@sol.localdomain>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 04, 2020 at 09:02:20PM -0700, Eric Biggers wrote:
> Introduced by:
> 
> commit 42f56b7a4a7db127a9d281da584152dc3d525d25
> Author: Ritesh Harjani <riteshh@linux.ibm.com>
> Date:   Wed May 20 12:10:34 2020 +0530
> 
>     ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling
> 

Hmm, syzbot reported this several times already.  Marking it as a duplicate
of the report where the discussion happened:

#syz dup: linux-next test error: BUG: using smp_processor_id() in preemptible [ADDR] code: syz-fuzzer/6792

- Eric
