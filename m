Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9D0185421
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Mar 2020 04:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgCNDEK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Mar 2020 23:04:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60400 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726485AbgCNDEK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Mar 2020 23:04:10 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02E33b7u026484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 23:03:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6DA51420E5E; Fri, 13 Mar 2020 23:03:37 -0400 (EDT)
Date:   Fri, 13 Mar 2020 23:03:37 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCHv5 5/6] ext4: Move ext4_fiemap to use iomap framework.
Message-ID: <20200314030337.GL225435@mit.edu>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <b9f45c885814fcdd0631747ff0fe08886270828c.1582880246.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f45c885814fcdd0631747ff0fe08886270828c.1582880246.git.riteshh@linux.ibm.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 28, 2020 at 02:56:58PM +0530, Ritesh Harjani wrote:
> This patch moves ext4_fiemap to use iomap framework.
> For xattr a new 'ext4_iomap_xattr_ops' is added.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
					
