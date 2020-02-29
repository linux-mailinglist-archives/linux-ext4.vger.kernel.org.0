Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B80A174877
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Feb 2020 18:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgB2RnG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Feb 2020 12:43:06 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40149 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727349AbgB2RnG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Feb 2020 12:43:06 -0500
Received: from callcc.thunk.org (75-104-88-164.mobility.exede.net [75.104.88.164] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01THgodj013267
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Feb 2020 12:42:58 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 92F1742045B; Sat, 29 Feb 2020 12:42:49 -0500 (EST)
Date:   Sat, 29 Feb 2020 12:42:49 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ext4: convert file system to meta_bg if needed during resizing
Message-ID: <20200229174249.GB7378@mit.edu>
References: <633e75c4-acdc-1b88-ab47-4e922aac93d7@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <633e75c4-acdc-1b88-ab47-4e922aac93d7@canonical.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Feb 29, 2020 at 12:39:34AM +0000, Colin Ian King wrote:
> Hi,
> 
> static analysis with Coverity has found an issue in function
> ext4_convert_meta_bg() with the following commit
> 
> commit 1c6bd7173d66b3dfdefcedb38cabc1fb03997509
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Thu Sep 13 10:19:24 2012 -0400
> 
>     ext4: convert file system to meta_bg if needed during resizing
> 
> The analysis is as follows:
> 
> 1898
> 1899 errout:
> 1900        ret = ext4_journal_stop(handle);
> 1901        if (!err)
> 
> Unused value (UNUSED_VALUE)assigned_value: Assigning value from ret to
> err here, but that stored value is not used.
> 
> 1902                err = ret;
> 1903        return ret;

Line 1903 should be "return err".

Want to send a patch, or shall I just commit the fix?

     	       	      	       	      - Ted
