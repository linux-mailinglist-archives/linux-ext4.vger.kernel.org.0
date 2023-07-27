Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68610764ED3
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jul 2023 11:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjG0JLD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jul 2023 05:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjG0JKr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Jul 2023 05:10:47 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568FF49EA
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 01:55:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6748a616e17so192446b3a.1
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690448142; x=1691052942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiPjRg1/kjwO6K5zl232SDHPqYtmZOtFvHbsJXMq+7g=;
        b=Umb+YV+a9lWFhAL8II9iFkMStUOOBYcco6VfVBA99lXKZrqzVwUjfYjnKm4Dm0LFjT
         qdoJauj14z5/Q/ALZNZe4hty9eUQzFUzAPUNYhh89WT1GQpVMRyZmNBBpLKeWi1ZbclH
         LZhMvQeV3S/E/ICy+9O5ITOO1Phn4D+1/k/6DGPG+fLuYZVwP+5BQnq4IpnQhN9xTXZe
         rfTcvD1n0zxeVBrWB1YcR+3kK3++SSPnDRJs7hwNhsakSHiwU6PBsTieOJN2pDWuMDWg
         xnIMDcCLv5tsUy7qwBc5TOF+eIq3rIHBy6gcXooMjKSZ0a9wuV4u6V1UPp0vjKeCWB6q
         aakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448142; x=1691052942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiPjRg1/kjwO6K5zl232SDHPqYtmZOtFvHbsJXMq+7g=;
        b=cMuseZ0+nQIReoQeQDUX2/ZaZjhJOaiV58NWPtUrHCKgo/IiLtyXmC6GrbiUeGAUSQ
         IgPq94r2G9T70eDSpZEkfrh1zVY6VoJRQhT6YnfK74lb1brBRPeQTkEEyEtr/ooT08h/
         TEnlS8cJJa5jlFCcOHKcC/ylbtF8wpYZQ+1ASlsqFt2GLAoATJOrpGJ7fLNROFDqsDd3
         /Yc19eEtc0g+DVaNhwp/Vsh9vLxwYazvnSrh77hVW7KP2pvqL6fGTo1cc0Fsp2QD7lXJ
         5FTlsFESxg8ujIvlPiL+LV0GXdQhlkfYaasMRTlvACYftwyu69fEcVm9smTC8Htc7SAE
         kRZw==
X-Gm-Message-State: ABy/qLZiw9J/verV+P0b8IKpcKBoZFFTUe0GKhxiUOab9s/9INDXmhAs
        KoL1agsN9xQl+LxLpxuzBOXMPA==
X-Google-Smtp-Source: APBJJlGwmdjot/rbtwF9nTotnOmqaOAtVmCVUqRrFxhkDx7eGx5gFUYRsJSjv9frk6zdjI0egP1lkA==
X-Received: by 2002:a17:902:e891:b0:1b3:d4bb:3515 with SMTP id w17-20020a170902e89100b001b3d4bb3515mr5854967plg.0.1690448141745;
        Thu, 27 Jul 2023 01:55:41 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001bbb1eec92esm1023927plb.281.2023.07.27.01.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 01:55:41 -0700 (PDT)
Message-ID: <56ee1d92-28ee-81cb-9c41-6ca7ea6556b0@bytedance.com>
Date:   Thu, 27 Jul 2023 16:55:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 28/49] dm zoned: dynamically allocate the dm-zoned-meta
 shrinker
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-29-zhengqi.arch@bytedance.com>
 <baaf7de4-9a0e-b953-2b6a-46e60c415614@kernel.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <baaf7de4-9a0e-b953-2b6a-46e60c415614@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On 2023/7/27 16:30, Damien Le Moal wrote:
> On 7/27/23 17:04, Qi Zheng wrote:
>> In preparation for implementing lockless slab shrink, use new APIs to
>> dynamically allocate the dm-zoned-meta shrinker, so that it can be freed
>> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
>> read-side critical section when releasing the struct dmz_metadata.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   drivers/md/dm-zoned-metadata.c | 28 ++++++++++++++++------------
>>   1 file changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
>> index 9d3cca8e3dc9..0bcb26a43578 100644
>> --- a/drivers/md/dm-zoned-metadata.c
>> +++ b/drivers/md/dm-zoned-metadata.c
>> @@ -187,7 +187,7 @@ struct dmz_metadata {
>>   	struct rb_root		mblk_rbtree;
>>   	struct list_head	mblk_lru_list;
>>   	struct list_head	mblk_dirty_list;
>> -	struct shrinker		mblk_shrinker;
>> +	struct shrinker		*mblk_shrinker;
>>   
>>   	/* Zone allocation management */
>>   	struct mutex		map_lock;
>> @@ -615,7 +615,7 @@ static unsigned long dmz_shrink_mblock_cache(struct dmz_metadata *zmd,
>>   static unsigned long dmz_mblock_shrinker_count(struct shrinker *shrink,
>>   					       struct shrink_control *sc)
>>   {
>> -	struct dmz_metadata *zmd = container_of(shrink, struct dmz_metadata, mblk_shrinker);
>> +	struct dmz_metadata *zmd = shrink->private_data;
>>   
>>   	return atomic_read(&zmd->nr_mblks);
>>   }
>> @@ -626,7 +626,7 @@ static unsigned long dmz_mblock_shrinker_count(struct shrinker *shrink,
>>   static unsigned long dmz_mblock_shrinker_scan(struct shrinker *shrink,
>>   					      struct shrink_control *sc)
>>   {
>> -	struct dmz_metadata *zmd = container_of(shrink, struct dmz_metadata, mblk_shrinker);
>> +	struct dmz_metadata *zmd = shrink->private_data;
>>   	unsigned long count;
>>   
>>   	spin_lock(&zmd->mblk_lock);
>> @@ -2936,19 +2936,23 @@ int dmz_ctr_metadata(struct dmz_dev *dev, int num_dev,
>>   	 */
>>   	zmd->min_nr_mblks = 2 + zmd->nr_map_blocks + zmd->zone_nr_bitmap_blocks * 16;
>>   	zmd->max_nr_mblks = zmd->min_nr_mblks + 512;
>> -	zmd->mblk_shrinker.count_objects = dmz_mblock_shrinker_count;
>> -	zmd->mblk_shrinker.scan_objects = dmz_mblock_shrinker_scan;
>> -	zmd->mblk_shrinker.seeks = DEFAULT_SEEKS;
>>   
>>   	/* Metadata cache shrinker */
>> -	ret = register_shrinker(&zmd->mblk_shrinker, "dm-zoned-meta:(%u:%u)",
>> -				MAJOR(dev->bdev->bd_dev),
>> -				MINOR(dev->bdev->bd_dev));
>> -	if (ret) {
>> -		dmz_zmd_err(zmd, "Register metadata cache shrinker failed");
>> +	zmd->mblk_shrinker = shrinker_alloc(0,  "dm-zoned-meta:(%u:%u)",
>> +					    MAJOR(dev->bdev->bd_dev),
>> +					    MINOR(dev->bdev->bd_dev));
>> +	if (!zmd->mblk_shrinker) {
>> +		dmz_zmd_err(zmd, "Allocate metadata cache shrinker failed");
> 
> ret is not set here, so dmz_ctr_metadata() will return success. You need to add:
> 		ret = -ENOMEM;
> or something.

Indeed, will fix.

>>   		goto err;
>>   	}
>>   
>> +	zmd->mblk_shrinker->count_objects = dmz_mblock_shrinker_count;
>> +	zmd->mblk_shrinker->scan_objects = dmz_mblock_shrinker_scan;
>> +	zmd->mblk_shrinker->seeks = DEFAULT_SEEKS;
>> +	zmd->mblk_shrinker->private_data = zmd;
>> +
>> +	shrinker_register(zmd->mblk_shrinker);
> 
> I fail to see how this new shrinker API is better... Why isn't there a
> shrinker_alloc_and_register() function ? That would avoid adding all this code
> all over the place as the new API call would be very similar to the current
> shrinker_register() call with static allocation.

In some registration scenarios, memory needs to be allocated in advance.
So we continue to use the previous prealloc/register_prepared()
algorithm. The shrinker_alloc_and_register() is just a helper function
that combines the two, and this increases the number of APIs that
shrinker exposes to the outside, so I choose not to add this helper.

Thanks,
Qi

> 
>> +
>>   	dmz_zmd_info(zmd, "DM-Zoned metadata version %d", zmd->sb_version);
>>   	for (i = 0; i < zmd->nr_devs; i++)
>>   		dmz_print_dev(zmd, i);
>> @@ -2995,7 +2999,7 @@ int dmz_ctr_metadata(struct dmz_dev *dev, int num_dev,
>>    */
>>   void dmz_dtr_metadata(struct dmz_metadata *zmd)
>>   {
>> -	unregister_shrinker(&zmd->mblk_shrinker);
>> +	shrinker_free(zmd->mblk_shrinker);
>>   	dmz_cleanup_metadata(zmd);
>>   	kfree(zmd);
>>   }
> 
