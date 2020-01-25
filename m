Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7BA1493D1
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2020 07:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgAYGnw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Jan 2020 01:43:52 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44433 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725781AbgAYGnw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Jan 2020 01:43:52 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P6hjR9017900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jan 2020 01:43:47 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3CEFB42014A; Sat, 25 Jan 2020 01:43:44 -0500 (EST)
Date:   Sat, 25 Jan 2020 01:43:44 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] mmp: don't assume NUL termination for MMP strings
Message-ID: <20200125064344.GA1108497@mit.edu>
References: <20191231220724.GA118765@mit.edu>
 <1579038138-49231-1-git-send-email-adilger@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579038138-49231-1-git-send-email-adilger@dilger.ca>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 14, 2020 at 02:42:17PM -0700, Andreas Dilger wrote:
> Don't assume that mmp_nodename and mmp_bdevname are NUL terminated,
> since very long node/device names may completely fill the buffers.
> 
> Limit string printing to the maximum buffer size for safety, and
> change the field definitions to __u8 to make it more clear that
> they are not NUL-terminated strings, as is done with other strings
> in the superblock that do not have NUL termination.
> 
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>

Applied, thanks.

					- Ted
