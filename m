Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F12DC60F
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2019 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393118AbfJRN2I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Oct 2019 09:28:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53053 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733113AbfJRN2I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Oct 2019 09:28:08 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9IDS2va032678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Oct 2019 09:28:04 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C50DB420458; Fri, 18 Oct 2019 09:28:02 -0400 (EDT)
Date:   Fri, 18 Oct 2019 09:28:02 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 12/13] docs: Add fast commit documentation
Message-ID: <20191018132802.GE21137@mit.edu>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-13-harshadshirwadkar@gmail.com>
 <20191018015655.GB21137@mit.edu>
 <C41A9852-DFA0-4F1A-A984-29A71D23CEFB@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C41A9852-DFA0-4F1A-A984-29A71D23CEFB@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 18, 2019 at 01:51:56PM +0900, Andreas Dilger wrote:
> What about rename or hard link?

Neither is currently handled by the fast commit patches, but each
operation can fit inside a single block, so it could be handled as a
update to a single inode.  In the case of rename, we will need to add
some tags to indicate the desintation directory and directory enrty
name, and whether or not there is a destination inode which needs to
have its refcount dropped and possibly deleted.

Harshad, we probably should handle them, since in order to support
NFS, the nfs server will send the rename or hard link request,
followed by a commit metadata request, and that commit metadata
request needs to persist the rename or link.  So for the purposes of
accelerating NFS, we should handle these commands.

If we don't handle these commands, we will need to declare the inode
as fast commit ineligible, so that we force a full journal commit when
the commit metadata request is received.

						- Ted
