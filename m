Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6909B476A6
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Jun 2019 22:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfFPUCB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Jun 2019 16:02:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49768 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727211AbfFPUCA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Jun 2019 16:02:00 -0400
Received: from callcc.thunk.org (mta-184-55-41-221.cinci.rr.com [184.55.41.221] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5GK1smp031827
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jun 2019 16:01:55 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4236D420484; Sun, 16 Jun 2019 16:01:54 -0400 (EDT)
Date:   Sun, 16 Jun 2019 16:01:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: [PATCH v3 2/2] shared/012: Add tests for filename casefolding
 feature
Message-ID: <20190616200154.GA7251@mit.edu>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
 <20190616144440.GD15846@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616144440.GD15846@desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jun 16, 2019 at 10:44:40PM +0800, Eryu Guan wrote:
> On Wed, Jun 12, 2019 at 02:40:33PM -0400, Gabriel Krisman Bertazi wrote:
> Test looks good to me, and test passes for me with v5.2-rc4 kernel and
> latest e2fsprogs, thanks! Just that, I moved the test to generic, as we
> have all the needed _require rules ready to _notrun on unsupported fs,
> so it's ready to be generic. (Sorry I was not involved with the
> ext4-shared-generic discussion in the first place)

Just to clear up my confusion, what's the distinction between shared
and generic?  Is it that if there are explicit "only run this test on
file systems xxx, yyy, and zzz declarations", then it should be
shared, and otherwise it should be in generic?

						- Ted
