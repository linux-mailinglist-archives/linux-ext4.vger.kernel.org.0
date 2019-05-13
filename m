Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B12311AF8B
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2019 06:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfEMEnw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 May 2019 00:43:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfEMEnw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 May 2019 00:43:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 480622026B;
        Mon, 13 May 2019 04:43:50 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAE774B6;
        Mon, 13 May 2019 04:43:49 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id ED18B18089CA;
        Mon, 13 May 2019 04:43:48 +0000 (UTC)
Date:   Mon, 13 May 2019 00:43:48 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org,
        david@redhat.com, jasowang@redhat.com, david@fromorbit.com,
        qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
        adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
        aarcange@redhat.com, dave jiang <dave.jiang@intel.com>,
        jstaron@google.com, linux-nvdimm@lists.01.org,
        vishal l verma <vishal.l.verma@intel.com>,
        willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org,
        jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org,
        kilobyte@angband.pl, riel@surriel.com,
        yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com,
        pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>,
        lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com,
        tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, imammedo@redhat.com
Message-ID: <1713362444.28252458.1557722628363.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190512124954-mutt-send-email-mst@kernel.org>
References: <20190510155202.14737-1-pagupta@redhat.com> <20190510155202.14737-3-pagupta@redhat.com> <20190512124954-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v8 2/6] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.16.148, 10.4.195.12]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: IHi4BX5O2DPB0MTOeSCuwbiKswIAPw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 13 May 2019 04:43:51 +0000 (UTC)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


> > Guest reads the persistent memory range information from
> > Qemu over VIRTIO and registers it on nvdimm_bus. It also
> > creates a nd_region object with the persistent memory
> > range information so that existing 'nvdimm/pmem' driver
> > can reserve this into system memory map. This way
> > 'virtio-pmem' driver uses existing functionality of pmem
> > driver to register persistent memory compatible for DAX
> > capable filesystems.
> > 
> > This also provides function to perform guest flush over
> > VIRTIO from 'pmem' driver when userspace performs flush
> > on DAX memory range.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thank you, Michael.

Best regards,
Pankaj

> 
> > ---
> >  drivers/nvdimm/Makefile          |   1 +
> >  drivers/nvdimm/nd_virtio.c       | 129 +++++++++++++++++++++++++++++++
> >  drivers/nvdimm/virtio_pmem.c     | 117 ++++++++++++++++++++++++++++
> >  drivers/virtio/Kconfig           |  10 +++
> >  include/linux/virtio_pmem.h      |  60 ++++++++++++++
> >  include/uapi/linux/virtio_ids.h  |   1 +
> >  include/uapi/linux/virtio_pmem.h |  10 +++
> >  7 files changed, 328 insertions(+)
> >  create mode 100644 drivers/nvdimm/nd_virtio.c
> >  create mode 100644 drivers/nvdimm/virtio_pmem.c
> >  create mode 100644 include/linux/virtio_pmem.h
> >  create mode 100644 include/uapi/linux/virtio_pmem.h
> > 
> > diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
> > index 6f2a088afad6..cefe233e0b52 100644
> > --- a/drivers/nvdimm/Makefile
> > +++ b/drivers/nvdimm/Makefile
> > @@ -5,6 +5,7 @@ obj-$(CONFIG_ND_BTT) += nd_btt.o
> >  obj-$(CONFIG_ND_BLK) += nd_blk.o
> >  obj-$(CONFIG_X86_PMEM_LEGACY) += nd_e820.o
> >  obj-$(CONFIG_OF_PMEM) += of_pmem.o
> > +obj-$(CONFIG_VIRTIO_PMEM) += virtio_pmem.o nd_virtio.o
> >  
> >  nd_pmem-y := pmem.o
> >  
> > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > new file mode 100644
> > index 000000000000..ed7ddcc5a62c
> > --- /dev/null
> > +++ b/drivers/nvdimm/nd_virtio.c
> > @@ -0,0 +1,129 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * virtio_pmem.c: Virtio pmem Driver
> > + *
> > + * Discovers persistent memory range information
> > + * from host and provides a virtio based flushing
> > + * interface.
> > + */
> > +#include <linux/virtio_pmem.h>
> > +#include "nd.h"
> > +
> > + /* The interrupt handler */
> > +void host_ack(struct virtqueue *vq)
> > +{
> > +	unsigned int len;
> > +	unsigned long flags;
> > +	struct virtio_pmem_request *req, *req_buf;
> > +	struct virtio_pmem *vpmem = vq->vdev->priv;
> > +
> > +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > +	while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
> > +		req->done = true;
> > +		wake_up(&req->host_acked);
> > +
> > +		if (!list_empty(&vpmem->req_list)) {
> > +			req_buf = list_first_entry(&vpmem->req_list,
> > +					struct virtio_pmem_request, list);
> > +			req_buf->wq_buf_avail = true;
> > +			wake_up(&req_buf->wq_buf);
> > +			list_del(&req_buf->list);
> > +		}
> > +	}
> > +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(host_ack);
> > +
> > + /* The request submission function */
> > +int virtio_pmem_flush(struct nd_region *nd_region)
> > +{
> > +	int err, err1;
> > +	unsigned long flags;
> > +	struct scatterlist *sgs[2], sg, ret;
> > +	struct virtio_device *vdev = nd_region->provider_data;
> > +	struct virtio_pmem *vpmem = vdev->priv;
> > +	struct virtio_pmem_request *req;
> > +
> > +	might_sleep();
> > +	req = kmalloc(sizeof(*req), GFP_KERNEL);
> > +	if (!req)
> > +		return -ENOMEM;
> > +
> > +	req->done = false;
> > +	strcpy(req->name, "FLUSH");
> > +	init_waitqueue_head(&req->host_acked);
> > +	init_waitqueue_head(&req->wq_buf);
> > +	INIT_LIST_HEAD(&req->list);
> > +	sg_init_one(&sg, req->name, strlen(req->name));
> > +	sgs[0] = &sg;
> > +	sg_init_one(&ret, &req->ret, sizeof(req->ret));
> > +	sgs[1] = &ret;
> > +
> > +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > +	 /*
> > +	  * If virtqueue_add_sgs returns -ENOSPC then req_vq virtual
> > +	  * queue does not have free descriptor. We add the request
> > +	  * to req_list and wait for host_ack to wake us up when free
> > +	  * slots are available.
> > +	  */
> > +	while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req,
> > +					GFP_ATOMIC)) == -ENOSPC) {
> > +
> > +		dev_err(&vdev->dev, "failed to send command to virtio pmem"\
> > +			"device, no free slots in the virtqueue\n");
> > +		req->wq_buf_avail = false;
> > +		list_add_tail(&req->list, &vpmem->req_list);
> > +		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > +
> > +		/* When host has read buffer, this completes via host_ack */
> > +		wait_event(req->wq_buf, req->wq_buf_avail);
> > +		spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > +	}
> > +	err1 = virtqueue_kick(vpmem->req_vq);
> > +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > +
> > +	/*
> > +	 * virtqueue_add_sgs failed with error different than -ENOSPC, we can't
> > +	 * do anything about that.
> > +	 */
> > +	if (err || !err1) {
> > +		dev_info(&vdev->dev, "failed to send command to virtio pmem device\n");
> > +		err = -EIO;
> > +		goto ret;
> > +	}
> > +
> > +	/* When host has read buffer, this completes via host_ack */
> > +	wait_event(req->host_acked, req->done);
> > +	err = req->ret;
> > +ret:
> > +	kfree(req);
> > +	return err;
> > +};
> > +
> > +/* The asynchronous flush callback function */
> > +int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> > +{
> > +	int rc = 0;
> > +
> > +	/* Create child bio for asynchronous flush and chain with
> > +	 * parent bio. Otherwise directly call nd_region flush.
> > +	 */
> > +	if (bio && bio->bi_iter.bi_sector != -1) {
> > +		struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> > +
> > +		if (!child)
> > +			return -ENOMEM;
> > +		bio_copy_dev(child, bio);
> > +		child->bi_opf = REQ_PREFLUSH;
> > +		child->bi_iter.bi_sector = -1;
> > +		bio_chain(child, bio);
> > +		submit_bio(child);
> > +	} else {
> > +		if (virtio_pmem_flush(nd_region))
> > +			rc = -EIO;
> > +	}
> > +
> > +	return rc;
> > +};
> > +EXPORT_SYMBOL_GPL(async_pmem_flush);
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> > new file mode 100644
> > index 000000000000..cfc6381c4e5d
> > --- /dev/null
> > +++ b/drivers/nvdimm/virtio_pmem.c
> > @@ -0,0 +1,117 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * virtio_pmem.c: Virtio pmem Driver
> > + *
> > + * Discovers persistent memory range information
> > + * from host and registers the virtual pmem device
> > + * with libnvdimm core.
> > + */
> > +#include <linux/virtio_pmem.h>
> > +#include "nd.h"
> > +
> > +static struct virtio_device_id id_table[] = {
> > +	{ VIRTIO_ID_PMEM, VIRTIO_DEV_ANY_ID },
> > +	{ 0 },
> > +};
> > +
> > + /* Initialize virt queue */
> > +static int init_vq(struct virtio_pmem *vpmem)
> > +{
> > +	/* single vq */
> > +	vpmem->req_vq = virtio_find_single_vq(vpmem->vdev,
> > +				host_ack, "flush_queue");
> > +	if (IS_ERR(vpmem->req_vq))
> > +		return PTR_ERR(vpmem->req_vq);
> > +
> > +	spin_lock_init(&vpmem->pmem_lock);
> > +	INIT_LIST_HEAD(&vpmem->req_list);
> > +
> > +	return 0;
> > +};
> > +
> > +static int virtio_pmem_probe(struct virtio_device *vdev)
> > +{
> > +	int err = 0;
> > +	struct resource res;
> > +	struct virtio_pmem *vpmem;
> > +	struct nd_region_desc ndr_desc = {};
> > +	int nid = dev_to_node(&vdev->dev);
> > +	struct nd_region *nd_region;
> > +
> > +	if (!vdev->config->get) {
> > +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > +			__func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	vpmem = devm_kzalloc(&vdev->dev, sizeof(*vpmem), GFP_KERNEL);
> > +	if (!vpmem) {
> > +		err = -ENOMEM;
> > +		goto out_err;
> > +	}
> > +
> > +	vpmem->vdev = vdev;
> > +	vdev->priv = vpmem;
> > +	err = init_vq(vpmem);
> > +	if (err)
> > +		goto out_err;
> > +
> > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > +			start, &vpmem->start);
> > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > +			size, &vpmem->size);
> > +
> > +	res.start = vpmem->start;
> > +	res.end   = vpmem->start + vpmem->size-1;
> > +	vpmem->nd_desc.provider_name = "virtio-pmem";
> > +	vpmem->nd_desc.module = THIS_MODULE;
> > +
> > +	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> > +						&vpmem->nd_desc);
> > +	if (!vpmem->nvdimm_bus)
> > +		goto out_vq;
> > +
> > +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> > +
> > +	ndr_desc.res = &res;
> > +	ndr_desc.numa_node = nid;
> > +	ndr_desc.flush = async_pmem_flush;
> > +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> > +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> > +	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
> > +
> > +	if (!nd_region)
> > +		goto out_nd;
> > +	nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
> > +	return 0;
> > +out_nd:
> > +	err = -ENXIO;
> > +	nvdimm_bus_unregister(vpmem->nvdimm_bus);
> > +out_vq:
> > +	vdev->config->del_vqs(vdev);
> > +out_err:
> > +	dev_err(&vdev->dev, "failed to register virtio pmem memory\n");
> > +	return err;
> > +}
> > +
> > +static void virtio_pmem_remove(struct virtio_device *vdev)
> > +{
> > +	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
> > +
> > +	nvdimm_bus_unregister(nvdimm_bus);
> > +	vdev->config->del_vqs(vdev);
> > +	vdev->config->reset(vdev);
> > +}
> > +
> > +static struct virtio_driver virtio_pmem_driver = {
> > +	.driver.name		= KBUILD_MODNAME,
> > +	.driver.owner		= THIS_MODULE,
> > +	.id_table		= id_table,
> > +	.probe			= virtio_pmem_probe,
> > +	.remove			= virtio_pmem_remove,
> > +};
> > +
> > +module_virtio_driver(virtio_pmem_driver);
> > +MODULE_DEVICE_TABLE(virtio, id_table);
> > +MODULE_DESCRIPTION("Virtio pmem driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index 35897649c24f..9f634a2ed638 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -42,6 +42,16 @@ config VIRTIO_PCI_LEGACY
> >  
> >  	  If unsure, say Y.
> >  
> > +config VIRTIO_PMEM
> > +	tristate "Support for virtio pmem driver"
> > +	depends on VIRTIO
> > +	depends on LIBNVDIMM
> > +	help
> > +	This driver provides support for virtio based flushing interface
> > +	for persistent memory range.
> > +
> > +	If unsure, say M.
> > +
> >  config VIRTIO_BALLOON
> >  	tristate "Virtio balloon driver"
> >  	depends on VIRTIO
> > diff --git a/include/linux/virtio_pmem.h b/include/linux/virtio_pmem.h
> > new file mode 100644
> > index 000000000000..ab1da877575d
> > --- /dev/null
> > +++ b/include/linux/virtio_pmem.h
> > @@ -0,0 +1,60 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * virtio_pmem.h: virtio pmem Driver
> > + *
> > + * Discovers persistent memory range information
> > + * from host and provides a virtio based flushing
> > + * interface.
> > + **/
> > +
> > +#ifndef _LINUX_VIRTIO_PMEM_H
> > +#define _LINUX_VIRTIO_PMEM_H
> > +
> > +#include <linux/virtio_ids.h>
> > +#include <linux/module.h>
> > +#include <linux/virtio_config.h>
> > +#include <uapi/linux/virtio_pmem.h>
> > +#include <linux/libnvdimm.h>
> > +#include <linux/spinlock.h>
> > +
> > +struct virtio_pmem_request {
> > +	/* Host return status corresponding to flush request */
> > +	int ret;
> > +
> > +	/* command name*/
> > +	char name[16];
> > +
> > +	/* Wait queue to process deferred work after ack from host */
> > +	wait_queue_head_t host_acked;
> > +	bool done;
> > +
> > +	/* Wait queue to process deferred work after virt queue buffer avail */
> > +	wait_queue_head_t wq_buf;
> > +	bool wq_buf_avail;
> > +	struct list_head list;
> > +};
> > +
> > +struct virtio_pmem {
> > +	struct virtio_device *vdev;
> > +
> > +	/* Virtio pmem request queue */
> > +	struct virtqueue *req_vq;
> > +
> > +	/* nvdimm bus registers virtio pmem device */
> > +	struct nvdimm_bus *nvdimm_bus;
> > +	struct nvdimm_bus_descriptor nd_desc;
> > +
> > +	/* List to store deferred work if virtqueue is full */
> > +	struct list_head req_list;
> > +
> > +	/* Synchronize virtqueue data */
> > +	spinlock_t pmem_lock;
> > +
> > +	/* Memory region information */
> > +	uint64_t start;
> > +	uint64_t size;
> > +};
> > +
> > +void host_ack(struct virtqueue *vq);
> > +int async_pmem_flush(struct nd_region *nd_region, struct bio *bio);
> > +#endif
> > diff --git a/include/uapi/linux/virtio_ids.h
> > b/include/uapi/linux/virtio_ids.h
> > index 6d5c3b2d4f4d..32b2f94d1f58 100644
> > --- a/include/uapi/linux/virtio_ids.h
> > +++ b/include/uapi/linux/virtio_ids.h
> > @@ -43,5 +43,6 @@
> >  #define VIRTIO_ID_INPUT        18 /* virtio input */
> >  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
> >  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> > +#define VIRTIO_ID_PMEM         27 /* virtio pmem */
> >  
> >  #endif /* _LINUX_VIRTIO_IDS_H */
> > diff --git a/include/uapi/linux/virtio_pmem.h
> > b/include/uapi/linux/virtio_pmem.h
> > new file mode 100644
> > index 000000000000..fa3f7d52717a
> > --- /dev/null
> > +++ b/include/uapi/linux/virtio_pmem.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
> > +#define _UAPI_LINUX_VIRTIO_PMEM_H
> > +
> > +struct virtio_pmem_config {
> > +	__le64 start;
> > +	__le64 size;
> > +};
> > +#endif
> > --
> > 2.20.1
> 
> 
