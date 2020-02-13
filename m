Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD9C15C529
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2020 16:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgBMPxs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Feb 2020 10:53:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49836 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387397AbgBMP0B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Feb 2020 10:26:01 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01DFPuF1009211
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 10:25:57 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2E0A742032C; Thu, 13 Feb 2020 10:25:56 -0500 (EST)
Date:   Thu, 13 Feb 2020 10:25:56 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: don't assume that mmp_nodename/bdevname have NUL
Message-ID: <20200213152556.GC239974@mit.edu>
References: <1579983942-11927-1-git-send-email-adilger@dilger.ca>
 <1580076215-1048-1-git-send-email-adilger@dilger.ca>
 <D5CCD904-C596-4C05-B665-D28C63844D12@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D5CCD904-C596-4C05-B665-D28C63844D12@dilger.ca>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jan 26, 2020 at 03:06:36PM -0700, Andreas Dilger wrote:
> Ted, do you also want an ext4 patch with EXT4_LEN_STR() and a change of these
> char strings to __u8, along with similar changes to other non-NUL-terminated
> strings in the superblock, as was done for e2fsprogs?

Yes, it would be great to have that as a separate cleanup patch, thanks.

     	      	       	       - Ted
