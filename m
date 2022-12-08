Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B1F6471EE
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 15:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiLHOjW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Dec 2022 09:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiLHOi7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Dec 2022 09:38:59 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA6199F18
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 06:38:54 -0800 (PST)
Received: from [192.168.10.9] (unknown [39.45.130.220])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C0AAC6600358;
        Thu,  8 Dec 2022 14:38:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670510332;
        bh=fVIPKPFDngLOHac5pI91xJzjXDvZH+tRu3bzX92i4Wg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=RbyVPBipXibYq+GTsHGkpBb/xCG0ZMDylqr7AKlYYICOZwrakPvQHk6mWUaF/PCTT
         CXaEtbqB1ewYOkcoGeJJHX+v5FW/QoqmeArPu7Rhi7/atSjtTi+vhSzNxq6gEWpX48
         UR/jTk2c4FYcVjjsWqiqXtdxGhkI4Kj0CUvbaiOBVFRw0O1A1qhTUGoqzl9Y/gaITk
         ORTOT7tfbMDmDsR18XWA7w4/5Oj9hU2c2ygq5NBjfrW+YNGU1tsIwXvO0bo3JgOodG
         U8DP/ceYeWgInDRg62lA7jECD5g741ZtOtD6SFsJBcawe0bnTLWYIbIvU/UA7a1fUz
         b8Ze56T1pSDig==
Message-ID: <2859a108-3189-6407-2d11-6b9f0948f718@collabora.com>
Date:   Thu, 8 Dec 2022 19:38:46 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v9 0/8] Clean up the case-insensitive lookup path
To:     Gabriel Krisman Bertazi <gabriel@krisman.be>, tytso@mit.edu,
        Eric Biggers <ebiggers@kernel.org>
References: <20220913234150.513075-1-krisman@collabora.com>
 <Yy0t8WYhM+Dv3gX1@sol.localdomain> <87fsgi2lax.fsf@collabora.com>
 <87tu47thie.fsf@suse.de>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <87tu47thie.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 10/14/22 4:45 AM, Gabriel Krisman Bertazi wrote:
> Gabriel Krisman Bertazi <krisman@collabora.com> writes:
> 
>> Eric Biggers <ebiggers@kernel.org> writes:
>>
>>> On Tue, Sep 13, 2022 at 07:41:42PM -0400, Gabriel Krisman Bertazi wrote:
>>>> Hi,
>>>>
>>>> I'm resubmitting this as v9 since I think it has fallen through the
>>>> cracks :).  It is a collection of trivial fixes for casefold support on
>>>> ext4/f2fs. More details below.
>>>>
>>>> It has been sitting on the list for a while and most of it is r-b
>>>> already. I'm keeping the tags for this submission, since there is no
>>>> modifications from previous submissions, apart from a minor conflict
>>>> resolution when merging to linus/master.
>>>
>>> Who are you expecting to apply this?
>>
>> Hi Eric,
>>
>> There are three groups of changes here: libfs, ext4 and f2fs.  Since the
>> changes in libfs are self-contained and only affect these two
>> filesystems, I think it should be fine for them to go through a fs tree.
>>
>> The bulk of changes are ext4, and Ted mentioned on an earlier version
>> that he could pick the first patches of this series, so I'm thinking it
>> should all go through the ext4 tree.  If Jaegeuk acks, the f2fs changes
>> are safe to go with the rest, or I can send them afterwards as a
>> separate series once the libfs code is merged.
> 
> Ted,
> 
> Does the above plan work for you? Do you intend to pick this up for the
> next merge window?
It seems like this series hasn't been picked up. Any ideas on what can be done?

-- 
BR,
Muhammad Usama Anjum
