Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 148B3165677
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 06:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgBTFEk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Feb 2020 00:04:40 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43875 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725811AbgBTFEk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Feb 2020 00:04:40 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01K54WZ1027068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Feb 2020 00:04:33 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E9D5A4211EF; Thu, 20 Feb 2020 00:04:31 -0500 (EST)
Date:   Thu, 20 Feb 2020 00:04:31 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Suraj Jitindar Singh <surajjs@amazon.com>
Cc:     linux-ext4@vger.kernel.org, sblbir@amazon.com,
        sjitindarsingh@gmail.com, stable@vger-kernel.org
Subject: Re: [PATCH 1/3] ext4: introduce macro sbi_array_rcu_deref() to
 access rcu protected fields
Message-ID: <20200220050431.GE476845@mit.edu>
References: <20200219030851.2678-1-surajjs@amazon.com>
 <20200219030851.2678-2-surajjs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219030851.2678-2-surajjs@amazon.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 18, 2020 at 07:08:49PM -0800, Suraj Jitindar Singh wrote:
> The s_group_desc field in the super block info (sbi) is protected by rcu to
> prevent access to an invalid pointer during online resize operations.
> There are 2 other arrays in sbi, s_group_info and s_flex_groups, which
> require similar rcu protection which is introduced in the subsequent
> patches. Introduce a helper macro sbi_array_rcu_deref() to be used to
> provide rcu protected access to such fields.
> 
> Also update the current s_group_desc access site to use the macro.
> 
> Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
> Cc: stable@vger-kernel.org

Thanks, applied with the simplification suggested by Balbir.  Also
note that I generally use stable@kernel.org instead of
stable@vger.kernel.org, since that avoids sending excess mail to
stable@vger.kernel.org mailing list.  (The stable kernel scripts look
for stable@kernel.org as well as stable@vger.kernel.org.)  I've made
that change in the version of the patch that I applied.

	     	       	   	      	  - Ted
