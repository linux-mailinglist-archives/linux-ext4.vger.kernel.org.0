Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4BB15C603
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2020 17:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgBMP4O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Feb 2020 10:56:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49707 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729016AbgBMPZ2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Feb 2020 10:25:28 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01DFPN2R008981
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 10:25:24 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8008242032C; Thu, 13 Feb 2020 10:25:23 -0500 (EST)
Date:   Thu, 13 Feb 2020 10:25:23 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: don't assume that mmp_nodename/bdevname have NUL
Message-ID: <20200213152523.GB239974@mit.edu>
References: <1579983942-11927-1-git-send-email-adilger@dilger.ca>
 <1580076215-1048-1-git-send-email-adilger@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580076215-1048-1-git-send-email-adilger@dilger.ca>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jan 26, 2020 at 03:03:34PM -0700, Andreas Dilger wrote:
> Don't assume that the mmp_nodename and mmp_bdevname strings are NUL
> terminated, since they are filled in by snprintf(), which is not
> guaranteed to do so.
> 
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>

Applied, thanks.

					- Ted
