Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF3678054F
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 07:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357959AbjHRFFu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 01:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357985AbjHRFF2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 01:05:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6441935BD
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 22:05:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I55DZS026891
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 01:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692335115; bh=KeIy3TJn/qHPWevs4TvrrLQ1RDmo/jyO9zSDdbBAMpY=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=jpqDhC+zh1Fr0ubuYoxTTMFRGHKpdFklgHz71xSh6B/ZPJRklZXTbpc3Okl5rPxJV
         LTLH+M8y1sy52ssjrTlmeqHACh7Yvq0aESIHVgLBua9gXCjrLmDjfubkdBIVQ/LvUD
         lro5irJxi/VpjWx7UIq9/NyGqkrsmiI58oh/6/5dP81qCSjtSWgeFLWlFVY2RofPvX
         3eEINN6dstcTbkKdgc6kKmR5UT2p5Hbov4T4gzEJSFwYfjJBWuz7VqFOu8sJbT3xyL
         r4ncxvPtjrW8Qr0UpMaKH4DA6ztJIPn00eylhCwAAjAHYv1lSdiFcyAr7JFYmEVIQX
         THGz6nlcuHX4g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2F2C315C0501; Fri, 18 Aug 2023 01:05:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Brian Foster <bfoster@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>, Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v2] ext4: drop dio overwrite only flag and associated warning
Date:   Fri, 18 Aug 2023 01:05:06 -0400
Message-Id: <169233503391.3504102.15783755848776717382.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230810165559.946222-1-bfoster@redhat.com>
References: <20230810165559.946222-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Thu, 10 Aug 2023 12:55:59 -0400, Brian Foster wrote:
> The commit referenced below opened up concurrent unaligned dio under
> shared locking for pure overwrites. In doing so, it enabled use of
> the IOMAP_DIO_OVERWRITE_ONLY flag and added a warning on unexpected
> -EAGAIN returns as an extra precaution, since ext4 does not retry
> writes in such cases. The flag itself is advisory in this case since
> ext4 checks for unaligned I/Os and uses appropriate locking up
> front, rather than on a retry in response to -EAGAIN.
> 
> [...]

Applied, thanks!

[1/1] ext4: drop dio overwrite only flag and associated warning
      commit: 9744b58f04b77a0666a996f901c7f667ca39ac34

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
