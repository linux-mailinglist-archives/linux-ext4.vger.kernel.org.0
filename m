Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A72D417B15D
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2020 23:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgCEWXf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Mar 2020 17:23:35 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57838 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726067AbgCEWXf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Mar 2020 17:23:35 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 025MNP26009075
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Mar 2020 17:23:26 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3F57342045B; Thu,  5 Mar 2020 17:23:25 -0500 (EST)
Date:   Thu, 5 Mar 2020 17:23:25 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     madhuparnabhowmik10@gmail.com
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Subject: Re: [PATCH] fs: ext4: mballoc.c: Use built-in RCU list checking
Message-ID: <20200305222325.GG20967@mit.edu>
References: <20200213152558.7070-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213152558.7070-1-madhuparnabhowmik10@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 13, 2020 at 08:55:58PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> list_for_each_entry_rcu() has built-in RCU and lock checking.
> 
> Pass cond argument to list_for_each_entry_rcu() to silence
> false lockdep warning when CONFIG_PROVE_RCU_LIST is enabled
> by default.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Applied, thanks.

						- Ted
